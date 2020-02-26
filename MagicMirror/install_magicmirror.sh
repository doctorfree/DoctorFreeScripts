#!/bin/bash
#
MM_BASE=${HOME}/MagicMirror
MODULES="MMM-BackgroundSlideshow MMM-DarkSkyForecast MMM-iFrame \
         MMM-ModuleScheduler MMM-NetworkScanner MMM-RAIN-RADAR \
         MMM-Remote-Control MMM-Solar MMM-stocks MMM-SystemStats"

[ -d ${MM_BASE} ] && {
    echo "Moving existing ${MM_BASE} to ${MM_BASE}-$$"
    mv ${MM_BASE} ${MM_BASE}-$$
}

# Install MMPM
cd ${HOME}
echo "Installing MMPM and dependencies"
sudo apt install python3 python3-pip -y && \
      git clone https://github.com/Bee-Mar/mmpm.git && \
      cd mmpm && \
      make && \
      echo "export PATH=$PATH:${HOME}/.local/bin" >> ${HOME}/.bashrc && \
      source ~/.bashrc

# Install MagicMirror
cd ${HOME}
echo "Installing MagicMirror"
#mmpm -M
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install -y nodejs
git clone https://github.com/MichMich/MagicMirror
cd MagicMirror
npm install
npm install electron@6.0.12

# Install MagicMirror Modules
[ -d ${MM_BASE}/modules ] || {
    echo "MagicMirror install problem: no directory ${MM_BASE}/modules. Exiting."
    exit 1
}

echo "Installing MagicMirror modules: ${MODULES}"
cd ${MM_BASE}/modules
for module in ${MODULES}
do
    mmpm -i ${module}
done
echo "Installing MagicMirror module mmm-hue-lights"
git clone https://github.com/michael5r/mmm-hue-lights.git

[ -d ${HOME}/src ] || mkdir ${HOME}/src
cd ${HOME}/src
[ -d Scripts ] || {
    echo "Cloning Scripts repo"
    git clone ssh://gitlab.com/doctorfree/Scripts.git
}
cd Scripts/MagicMirror 
echo "Installing Scripts/MagicMirror scripts"
[ -d /usr/local/bin ] || sudo mkdir /usr/local/bin
./chkinst.sh -f -i

# Install jq JSON parsing utility
echo "Installing jq JSON parsing utility"
sudo apt-get -y install jq

# Install Duplicity backup utility
echo "Installing Duplicity backup utility"
sudo apt-get -y install duplicity

# Install fswebcam
echo "Installing fswebcam utility"
sudo apt install fswebcam

# For now, use the sample config provided by MagicMirror
cd ${MM_BASE}/config
ln -s config.js.sample config.js

# Install pm2
echo "Installing pm2 utility"
sudo npm install -g pm2
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 \
    startup systemd -u pi --hp /home/pi

# Enable and start the SSH service
sudo systemctl enable ssh
sudo systemctl start ssh

cd ${HOME}
printf "#!/bin/bash\ncd ~/MagicMirror\nDISPLAY=:0 npm start\n" > mm.sh
chmod 755 mm.sh
pm2 start mm.sh
pm2 save

echo "Installing Vim GUI, exuberant-ctags, and Runtime packages"
sudo apt-get -y install vim-gui-common vim-runtime exuberant-ctags

echo "Removing unused packages"
sudo apt-get -y autoremove

echo ""
echo "==========!! TO DO !!=============="
echo "Follow instructions at:"
echo "https://forum.magicmirror.builders/topic/5327/sync-private-icloud-calendar-with-magicmirror/2?page=1"
echo "to setup Apple ical calendar module"
echo "==================================="
echo ""
echo "==========!! TO DO !!=============="
echo "Update the following files with api keys and other private settings:"
echo "/usr/local/bin/chktemp"
echo "/usr/local/bin/gethue"
echo "/usr/local/bin/getquote"
echo "/usr/local/bin/send_sms"
echo "${HOME}/MagicMirror/config/config-server.js"
echo "${HOME}/MagicMirror/config/config-iframe.js"
echo "${HOME}/MagicMirror/config/config-weather.js"
echo "${HOME}/MagicMirror/config/config-plex.js"
echo "${HOME}/MagicMirror/config/config-calendar.js"
echo "${HOME}/MagicMirror/config/config-noback.js"
echo "${HOME}/MagicMirror/config/config-default.js"
echo "==================================="
echo ""
echo "Done"
