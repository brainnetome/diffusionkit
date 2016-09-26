# install DiffusionKit
wget https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160618/DiffusionKitSetup-x86_64-v1.3-r160923.tar.gz
tar zxvf DiffusionKitSetup-x86_64-v1.3-r160923.tar.gz
export PATH=$PATH:$(pwd)/DiffusionKitSetup-x86_64-v1.3-r160923/bin

# get the data and run!
if [ ! -f list.txt ]; then
  wget https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160923/list.txt
fi
if [ ! -f sub01.tar.gz ]; then
  wget https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160923/sub01.tar.gz
fi
if [ ! -f sub02.tar.gz ]; then
  wget https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160923/sub02.tar.gz
fi
if [ ! -f atlas.tar.gz ]; then
  wget https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160923/atlas.tar.gz
fi
if [ ! -f process_advanced.sh ]; then
  wget https://raw.githubusercontent.com/brainnetome/diffusionkit/master/source/static/process_advanced.sh
fi
chmod +x process_advanced.sh
./process_advanced.sh	
