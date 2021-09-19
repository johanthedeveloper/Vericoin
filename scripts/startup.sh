#!/bin/bash

#setup bootstrap
#printf "Checking bootstrap\n";
#/usr/libexec/vericoin/bootstrap.sh

#setup config file
printf "Checking configuration file\n";
/usr/libexec/vericoin/setupconfig.sh

#look config file
printf "Loading configuration file\n";
source /root/vericoin/vericoin.conf

printf "Startup\n";
if [ "$vericoin_stake" = true ] ; then
    echo 'Starting with stake'
    /usr/libexec/vericoin/vericoind_startwithstake.sh
else
    echo 'Starting without stake'
    /usr/libexec/vericoin/vericoind_startwithoutstake.sh
fi
printf "Finished starting\n";

#sleep script
sleep infinity

printf "Shutdown\n";
