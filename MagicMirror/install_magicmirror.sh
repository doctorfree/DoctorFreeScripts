#!/bin/bash
#
MM_BASE=${HOME}/MagicMirror
MODULES="MMM-BackgroundSlideshow MMM-DarkSkyForecast MMM-iFrame \
         MMM-ModuleScheduler MMM-NetworkScanner MMM-RAIN-RADAR \
         MMM-Remote-Control MMM-Solar MMM-stocks MMM-SystemStats"
LXSESSION="${HOME}/.config/lxsession"
AUTOSTART="${LXSESSION}/LXDE-pi/autostart"

[ -d ${MM_BASE} ] && {
    echo "Moving existing ${MM_BASE} to ${MM_BASE}-$$"
    mv ${MM_BASE} ${MM_BASE}-$$
}

cd ${HOME}

# Install MMPM
echo "Installing MMPM and dependencies"
sudo apt install python3 python3-pip -y && \
      git clone https://github.com/Bee-Mar/mmpm.git && \
      cd mmpm && \
      make && \
      echo "export PATH=$PATH:${HOME}/.local/bin" >> ${HOME}/.bashrc

. ~/.bashrc

cd ${HOME}

# Install MagicMirror
echo "Installing MagicMirror"
#mmpm -M
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - > /dev/null
sudo apt install -y nodejs > /dev/null
git clone https://github.com/MichMich/MagicMirror > /dev/null
cd MagicMirror
npm install > /dev/null
npm install electron@6.0.12 > /dev/null

# Install MagicMirror Modules
[ -d ${MM_BASE}/modules ] || {
    echo "MagicMirror install problem: no directory ${MM_BASE}/modules. Exiting."
    exit 1
}

echo "Installing MagicMirror modules: "
cd ${MM_BASE}/modules
for module in ${MODULES}
do
    printf "\tInstalling ${module} ... "
    mmpm -i ${module} > /dev/null
    printf " done\n"
done
echo "Installing MagicMirror module mmm-hue-lights"
git clone https://github.com/michael5r/mmm-hue-lights.git > /dev/null

[ -d ${HOME}/src ] || mkdir ${HOME}/src
cd ${HOME}/src
[ -d Scripts ] || {
    echo "Cloning Scripts repo"
    git clone ssh://gitlab.com/doctorfree/Scripts.git > /dev/null
}
cd Scripts/MagicMirror 
echo "Installing MagicMirror convenience scripts in /usr/local/bin"
[ -d /usr/local/bin ] || sudo mkdir /usr/local/bin
./chkinst.sh -f -i > /dev/null
sudo chown -R pi:pi ${HOME}/MagicMirror/config

echo "Prepending /usr/local/bin to PATH (see ${HOME}/.bashrc)"
echo "export PATH=/usr/local/bin:$PATH" >> ${HOME}/.bashrc

# Install jq JSON parsing utility
echo "Installing jq JSON parsing utility"
sudo apt-get -y install jq > /dev/null

# Install Duplicity backup utility
echo "Installing Duplicity backup utility"
sudo apt-get -y install duplicity > /dev/null

# Install fswebcam
echo "Installing fswebcam utility"
sudo apt install fswebcam > /dev/null

# For now, use the sample config provided by MagicMirror
cd ${MM_BASE}/config
ln -s config.js.sample config.js

# Install pm2
echo "Installing pm2 utility"
sudo npm install -g pm2 > /dev/null
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 \
    startup systemd -u pi --hp /home/pi > /dev/null

# Enable and start the SSH service
sudo systemctl enable ssh
sudo systemctl start ssh

cd ${HOME}
printf "#!/bin/bash\ncd ~/MagicMirror\nDISPLAY=:0 npm start\n" > mm.sh
chmod 755 mm.sh
pm2 --name MagicMirror start mm.sh
pm2 save

# Disable X11 screensaver
echo "Disabling screensaver"
cd ${HOME}/.config
cp -a /etc/xdg/lxsession ${LXSESSION}
printf "@xset s noblank\n@xset s off\n@xset -dpms\n" >> ${AUTOSTART}

echo "Installing Vim GUI, exuberant-ctags, and Runtime packages"
sudo apt-get -y install vim-gui-common vim-runtime exuberant-ctags > /dev/null

printf "\n============= iCal Sync Selection Dialog ==================\n"
PS3="${BOLD}Are you going to want to sync with an Apple iCal calendar? (enter number or text): ${NORMAL}"
options=(yes no skip)
select opt in "${options[@]}"
do
    case "$opt,$REPLY" in
        "no",*|*,"no"|"skip",*|*,"skip")
            break
            ;;
        "yes",*|*,"yes")
            echo "Installing vdirsyncer and dependencies"
            sudo apt-get -y install libxml2 libxslt1.1 zlib1g python3 > /dev/null
            pip3 install --user --ignore-installed vdirsyncer > /dev/null
            echo "Installing the vdirsyncer.service and vdirsyncer.timer"
            curl https://raw.githubusercontent.com/pimutils/vdirsyncer/master/contrib/vdirsyncer.service | sudo tee /etc/systemd/user/vdirsyncer.service > /dev/null
            curl https://raw.githubusercontent.com/pimutils/vdirsyncer/master/contrib/vdirsyncer.timer | sudo tee /etc/systemd/user/vdirsyncer.timer > /dev/null
            echo "Activating the vdirsyncer timer in systemd"
            systemctl --user enable vdirsyncer.timer
            printf "\nTo complete the vdirsyncer configuration you will need to"
            printf "\nfollow the instructions at:"
            printf "\n\thttps://forum.magicmirror.builders/topic/5327/sync-private-icloud-calendar-with-magicmirror/2?page=1"
            printf "\nCreate an app-specific iCloud password, create a vdirsyncer config file,"
            printf "\ndiscover the UUIDs of calendars you wish to sync, add those to your"
            printf "\nvdirsyncer config file, and sync your calendar(s)\n"
            break
            ;;
        *)
            printf "\nInvalid entry. Please try again"
            printf "\nEnter either a number or 'yes', 'no', or 'skip'\n"
            ;;
    esac
done

echo "Removing unused packages"
sudo apt-get -y autoremove > /dev/null

printf "\n============= Screen Orientation Selection Dialog ==================\n"
PS3="${BOLD}Do you want to rotate the screen 90 degrees left or right? (enter number or text): ${NORMAL}"
options=(no left right skip)
select opt in "${options[@]}"
do
    case "$opt,$REPLY" in
        "left",*|*,"left")
            printf "@xrandr --output HDMI-1 --rotate left\n" >> ${AUTOSTART}
            break
            ;;
        "right",*|*,"right")
            printf "@xrandr --output HDMI-1 --rotate right\n" >> ${AUTOSTART}
            break
            ;;
        "no",*|*,"no"|"skip",*|*,"skip")
            break
            ;;
        *)
            printf "\nInvalid entry. Please try again"
            printf "\nEnter either a number or text of one of the menu entries\n"
            ;;
    esac
done

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
