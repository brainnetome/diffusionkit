#!/usr/bin/env bash

# install the program  
wget https://github.com/liangfu/diffusionkit/releases/download/v1.1-r20160204/DiffusionKitSetup-x86_64-v1.1-r160204.tar.gz
tar zxvf DiffusionKitSetup-x86_64-v1.1-r160204.tar.gz
export PATH=$PATH:`pwd`/DiffusionKitSetup-x86_64-v1.1-r160204/bin

# get the data and run!
wget https://github.com/liangfu/diffusionkit/releases/download/v1.1-r20160204/list.txt
wget https://github.com/liangfu/diffusionkit/releases/download/v1.1-r20160204/sub01.tar.gz
wget https://github.com/liangfu/diffusionkit/releases/download/v1.1-r20160204/sub02.tar.gz
wget https://github.com/liangfu/diffusionkit/releases/download/v1.1-r20160204/atlas.tar.gz
wget https://github.com/liangfu/diffusionkit/releases/download/v1.1-r20160204/process.sh
./process.sh	
