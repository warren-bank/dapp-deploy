#!/usr/bin/env bash

log='./run.log'
dir='./deployments'

rm "$log"
rm -r "$dir"
mkdir "$dir"
# mkdir "$dir/1"
mkdir "$dir/2"
mkdir "$dir/3"

dapp build
# dapp deploy -c 'C_1' -o "$dir/1" >> "$log"
dapp deploy -c 'C_2' --params '{{C, ../1_libs/deployments/}}' -o "$dir/2" >> "$log"
dapp deploy -c 'C_3' --params "{{C_2, $dir/2/}}" -o "$dir/3" >> "$log"

command -v 'dapp-console' >/dev/null 2>&1 || exit 0;

cp ./out/C_2.abi "$dir/2"

dapp console -d "$dir/2" -i './js/script.js' >> "$log"
