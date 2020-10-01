#!/bin/bash

#look config file
printf "Loading configuration file\n";
source /root/vericoin/vericoin.conf

printf "Start vericoin deamon\n";
vericoind -daemon -staking -conf=~/.vericoin/vericoin.conf -wallet=wallet.dat -walletpassphrase=$vericoin_walletpassword &
printf "Finish vericoin deamon\n";

echo "Waiting for staking";

for i in 1 2 3 4 5
do
    sleep 120
    echo "Start staking for the $i times";
    vericoind walletpassphrase "$vericoin_walletpassword" 9999999 true
    printf "Finished staking\n";
done
