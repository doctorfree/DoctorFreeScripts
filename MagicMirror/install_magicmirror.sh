#!/bin/bash
#
## @file install_magicmirror.sh
## @brief Convenience script to install MagicMirror, modules, and configure the system
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2020, Ronald Joe Record, all rights reserved.
## @date Written 24-Feb-2020
## @version 1.0.1
##
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# The Software is provided "as is", without warranty of any kind, express or
# implied, including but not limited to the warranties of merchantability,
# fitness for a particular purpose and noninfringement. In no event shall the
# authors or copyright holders be liable for any claim, damages or other
# liability, whether in an action of contract, tort or otherwise, arising from,
# out of or in connection with the Software or the use or other dealings in
# the Software.
#
MM_BASE=${HOME}/MagicMirror
MODULES="MMM-BackgroundSlideshow MMM-DarkSkyForecast MMM-iFrame \
         MMM-ModuleScheduler MMM-NetworkScanner MMM-RAIN-RADAR \
         MMM-Remote-Control MMM-Solar MMM-stocks MMM-SystemStats \
         MMM-TelegramBot MMM-Tools MMM-AssistantMk2 MMM-YouTube \
         MMM-NotificationTrigger MMM-Volume MMM-News MMM-pages"
LXSESSION="${HOME}/.config/lxsession"
AUTOSTART="${LXSESSION}/LXDE-pi/autostart"
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

[ -d ${MM_BASE} ] && {
    echo "Moving existing ${MM_BASE} to ${MM_BASE}-$$"
    mv ${MM_BASE} ${MM_BASE}-$$
}

cd ${HOME}
[[ ":${PATH}:" == *":$HOME/.local/bin:"* ]] || export PATH=${PATH}:${HOME}/.local/bin

# Install MMPM
printf "\nInstalling MMPM and dependencies ..."
sudo apt install python3 python3-pip -y > /dev/null 2>&1 && \
      git clone https://github.com/Bee-Mar/mmpm.git > /dev/null 2>&1 && \
      cd mmpm && \
      make > /dev/null 2>&1 && \
      echo "export PATH=${PATH}:${HOME}/.local/bin" >> ${HOME}/.bashrc
printf "\tDone"

. ~/.bashrc

cd ${HOME}

# Install MagicMirror
printf "\nInstalling MagicMirror ..."
curl -sL https://deb.nodesource.com/setup_10.x 2> /dev/null | sudo -E bash - > /dev/null 2>&1
sudo apt install -y nodejs > /dev/null 2>&1
git clone https://github.com/MichMich/MagicMirror > /dev/null 2>&1
cd MagicMirror
npm install > /dev/null 2>&1
npm install electron@6.0.12 > /dev/null 2>&1
printf "\t\tDone\n"

# Install MagicMirror Modules
[ -d ${MM_BASE}/modules ] || {
    echo "MagicMirror install problem: no directory ${MM_BASE}/modules. Exiting."
    exit 1
}

echo "Installing MagicMirror modules: "
cd ${MM_BASE}/modules
for module in ${MODULES}
do
    printf "\tInstalling MagicMirror module ${module} ..."
    mmpm -i ${module} > /dev/null 2>&1
    if [ "${module}" == "MMM-BackgroundSlideshow" ]
    then
        printf "\tDone\n"
    else
        if [ "${module}" == "MMM-Solar" ] || \
           [ "${module}" == "MMM-iFrame" ] || \
           [ "${module}" == "MMM-News" ] || \
           [ "${module}" == "MMM-pages" ] || \
           [ "${module}" == "MMM-Tools" ] || \
           [ "${module}" == "MMM-Volume" ] || \
           [ "${module}" == "MMM-YouTube" ] || \
           [ "${module}" == "MMM-stocks" ]
        then
            printf "\t\t\tDone\n"
        else
            printf "\t\tDone\n"
        fi
    fi
done
printf "\tInstalling MagicMirror module mmm-hue-lights ..."
git clone https://github.com/michael5r/mmm-hue-lights.git > /dev/null 2>&1
printf "\t\tDone\n"
printf "\tInstalling MagicMirror module MMM-COVID-19 ..."
git clone https://github.com/eouia/MMM-COVID-19 > /dev/null 2>&1
printf "\t\tDone\n"
printf "\tInstalling MagicMirror module MMM-COVID-19 ...\n"
git clone https://github.com/mykle1/Hello-Lucy
cd Hello-Lucy/installers
bash dependencies.sh
printf "\n\tDone\n"
cd ${HOME}

# Audit and fix any discovered vulnerabilities
printf "\nAuditing and repairing any discovered vulnerabilities ..."
find MagicMirror -name package.json | grep -v /node_modules/ | while read package
do
    DIR=`dirname "$package"`
    [ -f ${DIR}/package-lock.json ] || continue
    cd ${DIR}
    npm audit > /dev/null 2>&1
    [ $? -eq 0 ] || {
        printf "\n\tFixing vulnerabilities in ${DIR}"
        npm audit fix > /dev/null 2>&1
    }
    cd ${HOME}
done
printf "\nDone detecting and repairing vulnerabilities\n"

[ -d ${HOME}/src ] || mkdir ${HOME}/src
cd ${HOME}/src
[ -d Scripts ] || {
    printf "\nCloning Scripts repository ..."
    git clone ssh://gitlab.com/doctorfree/Scripts.git > /dev/null 2>&1
    printf "\tDone\n"
}

if [ -d ${HOME}/src/Scripts/MagicMirror ]
then
    cd ${HOME}/src/Scripts/MagicMirror 
    printf "\nInstalling MagicMirror convenience scripts in /usr/local/bin ..."
    [ -d /usr/local/bin ] || sudo mkdir /usr/local/bin
    ./chkinst.sh -f -i > /dev/null 2>&1
    sudo chown -R pi:pi ${HOME}/MagicMirror/config
    printf "\tDone\n"
    [[ ":${PATH}:" == *":/usr/local/bin:"* ]] || {
        echo "Prepending /usr/local/bin to PATH (see ${HOME}/.bashrc)"
        echo "export PATH=/usr/local/bin:${PATH}" >> ${HOME}/.bashrc
    }
else
    echo "ERROR: Something went wrong with the Scripts git clone."
    echo "No directory $HOME/src/Scripts/MagicMirror"
    echo "Skipping installation of MagicMirror convenience scripts"
fi

# Install autofs so we can automount filesystems
printf "\nInstalling nfs-common and autofs ..."
sudo apt-get -y install nfs-common autofs > /dev/null 2>&1
printf "\tDone\n"

# Install arp-scan for MMM-NetworkScanner
printf "\nInstalling arp-scan for MMM-NetworkScanner ..."
sudo apt-get -y install arp-scan > /dev/null 2>&1
printf "\tDone"
printf "\nUpdating arp-scan vendor database ..."
[ -d /usr/share/arp-scan ] && {
    cd /usr/share/arp-scan
    sudo get-iab -v -u http://standards-oui.ieee.org/iab/iab.txt > /dev/null 2>&1
    sudo get-oui -v -u http://standards-oui.ieee.org/oui/oui.txt > /dev/null 2>&1
}
printf "\tDone\n"

# Install jq JSON parsing utility
printf "\nInstalling jq JSON parsing utility ..."
sudo apt-get -y install jq > /dev/null 2>&1
printf "\tDone\n"

# Install bc utility
printf "\nInstalling bc utility ..."
sudo apt-get -y install bc > /dev/null 2>&1
printf "\tDone\n"

# Install Duplicity backup utility
echo "Installing Duplicity backup utility"
sudo apt-get -y install duplicity > /dev/null 2>&1

# Install fswebcam
echo "Installing fswebcam utility"
sudo apt install fswebcam > /dev/null 2>&1

# For now, use the sample config provided by MagicMirror
if [ -d ${MM_BASE}/config ]
then
    cd ${MM_BASE}/config
    ln -s config.js.sample config.js
else
    echo "ERROR: Something went wrong with the MagicMirror install."
    echo "No directory $MM_BASE/config"
    echo "Skipping linking of default MagicMirror config file"
fi

# Install pm2
echo "Installing pm2 utility"
sudo npm install -g pm2 > /dev/null 2>&1
sudo env PATH=${PATH}:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 \
    startup systemd -u pi --hp /home/pi > /dev/null 2>&1

# Enable and start the SSH service
printf "\n${BOLD}WARNING: this script enables SSH for remote login support.${NORMAL}"
printf "\nIf you are using the default user/password then this is a serious vulnerability."
printf "\nDo not use the default user/password and run this script."

printf "\n============= Default Password Selection Dialog ==================\n"
USER=`id -u -n`
PS3="${BOLD}Are you using the default password for user ${USER} ? (enter number or text): ${NORMAL}"
options=(yes no)
select opt in "${options[@]}"
do
    case "$opt,$REPLY" in
        "no",*|*,"no")
            echo "Enabling SSH"
            sudo systemctl enable ssh > /dev/null 2>&1
            sudo systemctl start ssh > /dev/null 2>&1
            break
            ;;
        "yes",*|*,"yes")
            echo "SSH not enabled"
            echo "In order to enable SSH, run the following commands:"
            printf "\tsudo systemctl enable ssh\n"
            printf "\tsudo systemctl start ssh\n"
            break
            ;;
        *)
            printf "\nInvalid entry. Please try again"
            printf "\nEnter '1', '2', 'yes', or 'no' to indicate if you are using the default password \n"
            ;;
    esac
done

cd ${HOME}
printf "#!/bin/bash\ncd ~/MagicMirror\nDISPLAY=:0 npm start\n" > mm.sh
chmod 755 mm.sh
pm2 --name MagicMirror start mm.sh > /dev/null 2>&1
sleep 5
pm2 save > /dev/null 2>&1
pm2 stop MagicMirror > /dev/null 2>&1

# Disable X11 screensaver
echo "Disabling screensaver"
cd ${HOME}/.config
cp -a /etc/xdg/lxsession ${LXSESSION}
cat ${AUTOSTART} | sed -e "s/@xscreensaver/#@xscreensaver/" > /tmp/autostart$$
cp /tmp/autostart$$ ${AUTOSTART}
rm -f /tmp/autostart$$
printf "@xset s noblank\n@xset s off\n@xset -dpms\n" >> ${AUTOSTART}
LDMCONF="/etc/lightdm/lightdm.conf"
cat ${LDMCONF} | sed -e "s/#xserver-command=X/xserver-command=X -s 0 -dpms/" > /tmp/ldm$$
sudo cp /tmp/ldm$$ ${LDMCONF}
rm -f /tmp/ldm$$

echo "Installing Vim GUI, exuberant-ctags, and Vim Runtime packages"
sudo apt-get -y install vim-gui-common vim-runtime exuberant-ctags > /dev/null 2>&1

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
            printf "\nInstalling vdirsyncer and dependencies ..."
            sudo apt-get -y install libxml2 libxslt1.1 zlib1g python3 > /dev/null 2>&1
            pip3 install --user --ignore-installed vdirsyncer > /dev/null 2>&1
            if [ -f ${HOME}/.local/bin/vdirsyncer ]
            then
                if [ -L /usr/bin/vdirsyncer ]
                then
                    printf "\nvdirsyncer already symlinked into /usr/bin"
                else
                    sudo ln -s ${HOME}/.local/bin/vdirsyncer /usr/bin/vdirsyncer
                fi
            else
                printf "\nWARNING: vdirsyncer not installed in $HOME/.local/bin"
                printf "\n\tLocate vdirsyncer and create a symbolic link in /usr/bin"
            fi
            printf "\nDone"
            printf "\nInstalling the vdirsyncer.service and vdirsyncer.timer ..."
            curl https://raw.githubusercontent.com/pimutils/vdirsyncer/master/contrib/vdirsyncer.service 2> /dev/null | sudo tee /etc/systemd/user/vdirsyncer.service > /dev/null 2>&1
            curl https://raw.githubusercontent.com/pimutils/vdirsyncer/master/contrib/vdirsyncer.timer 2> /dev/null | sudo tee /etc/systemd/user/vdirsyncer.timer > /dev/null 2>&1
            printf "\tDone"
            printf "\nActivating the vdirsyncer timer in systemd ..."
            systemctl --user enable vdirsyncer.timer > /dev/null 2>&1
            printf "\tDone\n"
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
sudo apt-get -y autoremove > /dev/null 2>&1

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
echo "Installation Done"
printf "\n${BOLD}Starting MagicMirror in 30 seconds${NORMAL}"
printf "\n${BOLD}You can stop MagicMirror to return to this screen with the command:${NORMAL}"
printf "\n\t${BOLD}/usr/local/bin/mirror stop${NORMAL}\n"
printf "or"
printf "\n\tpm2 stop MagicMirror\n"
sleep 30
pm2 start MagicMirror --update-env
