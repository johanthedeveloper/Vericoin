#!/bin/bash

if [ ! -f "/root/vericoin/vericoin.conf" ]; then
    echo "/root/vericoin/vericoin.conf not exist"

    mkdir -p /root/vericoin/

/bin/cat <<EOM >/root/vericoin/vericoin.conf
vericoin_stake=false
vericoin_walletpassword=yourpassword
EOM

chmod +x /root/vericoin/vericoin.conf

fi
