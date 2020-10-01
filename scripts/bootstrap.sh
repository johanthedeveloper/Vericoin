#!/bin/bash

if [ ! -d "/root/.vericoin/" ]; then
    echo "/root/.vericoin/ not exist"

    printf "\e[32mCreating directory\e[0m\n"
	mkdir -p /root/.vericoin/

    printf "\e[32mGetting bootstrap.zip\e[0m\n"
	wget https://pivericoin.blob.core.windows.net/pivericoin/bootstrap.zip -O /root/.vericoin/bootstrap.zip
	
    printf "\e[32mUnzipping bootstrap.zip\e[0m\n"
	unzip -q /root/.vericoin/bootstrap.zip -d /root/.vericoin/

    printf "\e[32mCopy content bootstrap\e[0m\n"
	mv /root/.vericoin/bootstrap/* /root/.vericoin/
	
	printf "\e[32mCopy directory bootstrap\e[0m\n"
	rm /root/.vericoin/bootstrap/ -r
	
	printf "\e[32mCopy file bootstrap.zip\e[0m\n"
	rm /root/.vericoin/bootstrap.zip 

	printf "\e[32mCreating vericoin.conf\e[0m\n"
	configurationfile=/root/.vericoin/vericoin.conf

	/bin/cat <<EOM >$configurationfile
addnode=emea.supernode.vericonomy.com
addnode=amer.supernode.vericonomy.com
addnode=apac.supernode.vericonomy.com

rpcuser=vericoinrpc
rpcpassword=5jswCEheDSfnR8btd8iUNA8A4bfddKLfps8apbE2KLLE
EOM

fi
