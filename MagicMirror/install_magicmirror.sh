#!/bin/bash
#
MM_BASE=$HOME/MagicMirror
MODULES="MMM-BackgroundSlideshow MMM-DarkSkyForecast MMM-iFrame \
         MMM-ModuleScheduler MMM-NetworkScanner MMM-RAIN-RADAR \
         MMM-Remote-Control MMM-Solar MMM-stocks MMM-SystemStats"

[ -d ${MM_BASE} ] && {
    echo "Moving existing ${MM_BASE} to ${MM_BASE}-$$"
    mv ${MM_BASE} ${MM_BASE}-$$
}

# Install MMPM
[ -d $HOME/src ] || mkdir $HOME/src
cd $HOME/src
echo "Installing MMPM and dependencies"
sudo apt install python3 python3-pip -y && \
      git clone https://github.com/Bee-Mar/mmpm.git && \
      cd mmpm && \
      make && \
      echo "export PATH=$PATH:$HOME/.local/bin" >> $HOME/.bashrc && \
      source ~/.bashrc

# Install MagicMirror
echo "Installing MagicMirror"
mmpm -M

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

cd $HOME/src
[ -d Scripts ] && {
    echo "Moving existing Scripts repo to Scripts-$$"
    mv Scripts Scripts-$$
}
echo "Cloning Scripts repo"
git clone ssh://gitlab.com/doctorfree/Scripts.git
cd Scripts/MagicMirror 
echo "Installing Scripts/MagicMirror scripts"
./chkinst.sh -f

# Install jq JSON parsing utility
echo "Installing jq JSON parsing utility"
sudo apt-get install jq

# Install Duplicity backup utility
echo "Installing Duplicity backup utility"
sudo apt-get install duplicity

# Install fswebcam
echo "Installing fswebcam utility"
sudo apt install fswebcam
