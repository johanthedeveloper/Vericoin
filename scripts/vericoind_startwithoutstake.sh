#!/bin/bash

printf "Start vericoin deamon\n";

#vericoind -daemon -conf=~/.vericoin/vericoin.conf &
vericoind -daemon 

printf "Finish vericoin deamon\n";