sudo apt-get update
sudo apt-get upgrade
sudo apt install ffmpeg
sudo apt-get install mencoder
sudo sh -c 'echo "deb https://mkvtoolnix.download/ubuntu/ $(lsb_release -sc) main"
/etc/apt/sources.list.d/bunkus.org.list'
sudo apt-get install wget
wget -q -O - https://mkvtoolnix.download/gpg-pub-moritzbunkus.txt | sudo apt-key add -
sudo apt-get update
sudo apt-get install mkvtoolnix mkvtoolnix-gui
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
sudo apt-get install python-pip
sudo pip install --upgrade google-api-python-client oauth2client progressbar2
sudo apt-get install unzip
sudo cd /usr/bin/
sudo wget https://github.com/tokland/youtube-upload/archive/master.zip
sudo unzip master.zip
sudo rm master.zip
cd youtube-upload-master
sudo python setup.py install
cd 
wget https://raw.githubusercontent.com/duszmox/transfer-vod/master/.mergeVods.sh
wget https://raw.githubusercontent.com/duszmox/transfer-vod/master/.vod.sh
sudo rm -rf *