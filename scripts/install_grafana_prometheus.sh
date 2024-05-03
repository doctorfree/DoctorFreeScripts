#!/usr/bin/env bash
#

add_grafana_repo() {
  # Install all the required dependencies
  ${SUDO} apt install gnupg2 apt-transport-https software-properties-common wget
  # Download and add the Grafana GPG key
  wget -q -O - https://packages.grafana.com/gpg.key > /tmp/grafana$$.key
  cat /tmp/grafana$$.key | gpg --dearmor | ${SUDO} tee /etc/apt/trusted.gpg.d/grafana.gpg > /dev/null
  rm -f /tmp/grafana$$.key
  # Add the Grafana repository to your APT source file
  echo 'deb [signed-by=/etc/apt/trusted.gpg.d/grafana.gpg] https://packages.grafana.com/oss/deb stable main' | ${SUDO} tee /etc/apt/sources.list.d/grafana.list
  # Update the repository index
  ${SUDO} apt update
}

install_grafana() {
  # Install Grafana
  ${SUDO} apt install grafana
  # Reload the systemd daemon.
  ${SUDO} systemctl daemon-reload
  # Start the Grafana service
  ${SUDO} systemctl start grafana-server
  # Check the status of Grafana
  ${SUDO} systemctl status grafana-server
  printf "\nChange the following lines:\n"
  printf "\n\thttp_addr =  localhost"
  printf "\n\t# The http port  to use"
  printf "\n\thttp_port = 3000"
  printf "\n\t# The public facing domain name used to access grafana from a browser"
  printf "\n\tdomain = grafana.example.com\n"
  printf "\nPress <Enter> to edit /etc/grafana/grafana.ini\n"
  read -r yn
  # Edit the Grafana configuration file
  ${SUDO} vi /etc/grafana/grafana.ini
  # Restart the Grafana service to apply the changes.
  ${SUDO} systemctl restart grafana-server
}

install_nginx() {
  # Install the Nginx package.
  ${SUDO} apt install nginx
  # Create an Nginx virtual host configuration file
  ngc=$(cat <<EOF
# this is required to proxy Grafana Live WebSocket connections.
map $http_upgrade $connection_upgrade {
  default upgrade;
  '' close;
}

server {
  listen      80;
  server_name grafana.example.com;


  access_log /var/log/nginx/grafana-access.log;
  error_log /var/log/nginx/grafana-error.log;

  location / {
    proxy_set_header Host $http_host;
    proxy_pass http://localhost:3000/;
  }

  # Proxy Grafana Live WebSocket connections.
  location /api/live {
    rewrite  ^/(.*)  /$1 break;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $connection_upgrade;
    proxy_set_header Host $http_host;
    proxy_pass http://localhost:3000/;
  }
}
EOF
)
  ${SUDO} echo "${ngc}" > ${ncfg}
  ${SUDO} cat ${ncfg} | sed -e "s/grafana.example.com/${host}/" > /tmp/ng$$
  ${SUDO} cp /tmp/ng$$ ${ncfg}
  ${SUDO} rm -f /tmp/ng$$
  # Restart the Nginx service to apply the changes
  ${SUDO} systemctl restart nginx
}

install_prometheus() {
  # add a user and group for Prometheus.
  ${SUDO} groupadd --system prometheus
  ${SUDO} useradd -s /sbin/nologin --system -g prometheus prometheus
  # Create the required directories for Prometheus.
  ${SUDO} mkdir /var/lib/prometheus
  for i in rules rules.d files_sd
  do
    ${SUDO} mkdir -p /etc/prometheus/${i}
  done
  # Download the latest version of Prometheus from the Git repo
  API_URL="https://api.github.com/repos/prometheus/prometheus/releases/latest"
  DL_URL=
  DL_URL=$(curl --silent ${AUTH_HEADER} "${API_URL}" \
    | jq --raw-output '.assets | .[]?.browser_download_url' \
    | grep "linux-${mach}")

  [ "${DL_URL}" ] && {
    wget --quiet -O /tmp/prometheus$$.tgz "${DL_URL}"
    chmod 644 /tmp/prometheus$$.tgz
    # Extract the downloaded file.
    mkdir /tmp/prom$$
    tar -C /tmp/prom$$ -xzf /tmp/prometheus$$.tgz
    # Change directory to Prometheus and copy all required files to desired locations
    cd /tmp/prom$$/prometheus*/
    ${SUDO} mv prometheus promtool /usr/local/bin/
    ${SUDO} mv consoles console_libraries prometheus.yml /etc/prometheus/
    rm -f /tmp/prometheus$$.tgz
    rm -rf /tmp/prom$$
  }
  # Set necessary permissions on the Prometheus directory.
  for i in rules rules.d files_sd
  do
    ${SUDO} chown -R prometheus:prometheus /etc/prometheus/${i}
  done
  for i in rules rules.d files_sd
  do
    ${SUDO} chmod -R 775 /etc/prometheus/${i}
  done
  ${SUDO} chown -R prometheus:prometheus /var/lib/prometheus/
  # Create a Systemd Service File for Prometheus
  sys=$(cat <<EOF
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=prometheus
Group=prometheus
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.enable-lifecycle

[Install]
WantedBy=multi-user.target[Install]
WantedBy=multi-user.target
EOF
)
  ${SUDO} echo "${sys}" > ${sysd}
  # Reload the systemd daemon to apply the changes
  ${SUDO} systemctl daemon-reload
  # Start and enable the Prometheus service
  ${SUDO} systemctl start prometheus
  ${SUDO} systemctl enable prometheus
  # Check the status of the Prometheus service using the following command.
  ${SUDO} systemctl status prometheus
}

install_node_exporter() {
  # Download the latest version of node_exporter
  API_URL="https://api.github.com/repos/prometheus/node_exporter/releases/latest"
  DL_URL=
  DL_URL=$(curl --silent ${AUTH_HEADER} "${API_URL}" \
    | jq --raw-output '.assets | .[]?.browser_download_url' \
    | grep "linux-${mach}")

  [ "${DL_URL}" ] && {
    wget --quiet -O /tmp/prometheus_node$$.tgz "${DL_URL}"
    chmod 644 /tmp/prometheus_node$$.tgz
    # Extract the downloaded file.
    mkdir /tmp/node$$
    tar -C /tmp/node$$ -xzf /tmp/prometheus_node$$.tgz
    # Change directory to Prometheus and copy all required files to desired locations
    cd /tmp/node$$/node_exporter*/
    ${SUDO} cp node_exporter /usr/local/bin
    rm -f /tmp/prometheus_node$$.tgz
    rm -rf /tmp/node$$
  }
  # Verify the node_exporter version
  node_exporter --version
  # Create a system file to manage the node_exporter service
  nes=$(cat <<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
EOF
)
  ${SUDO} echo "${nes}" > ${nsys}
  # Reload the system daemon
  ${SUDO} systemctl daemon-reload
  # Start the node_exporter service
  ${SUDO} systemctl start node_exporter
  # Verify the status of the node_exporter
  ${SUDO} systemctl status node_exporter
}

add_node_prometheus() {
  pym=$(cat <<EOF
- job_name: 'node_export'
    static_configs:
      - targets: ["localhost:9100"]
EOF
)
  ${SUDO} echo "${pym}" >> ${pyml}
  ${SUDO} systemctl restart prometheus
}

host=$(hostname)
pyml="/etc/prometheus/prometheus.yml"
ncfg="/etc/nginx/conf.d/grafana.conf"
sysd="/lib/systemd/system/prometheus.service"
nsys="/lib/systemd/system/node_exporter.service"

mach="amd64"
machine=$(uname -m)
[ "${machine}" == "arm64" ] && mach="arm64"

if [ "${GH_TOKEN}" ]; then
  AUTH_HEADER="-H \"Authorization: Bearer ${GH_TOKEN}\""
else
  AUTH_HEADER=
fi

SUDO=sudo
if [ "${EUID}" ]; then
  [ ${EUID} -eq 0 ] && SUDO=
else
  uid=$(id -u)
  [ ${uid} -eq 0 ] && SUDO=
fi

add_grafana_repo
install_grafana
install_nginx
install_prometheus
install_node_exporter
add_node_prometheus
