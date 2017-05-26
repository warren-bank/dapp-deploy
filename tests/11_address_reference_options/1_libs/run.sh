#!/usr/bin/env bash

log_1='./1_deploy_libraries.log'
log_2='./2_deploy_contract_with_gas_estimate.log'
log_3='./3_deploy_contract_with_additional_gas.log'
dir='./deployments'

rm "$log_1"
rm "$log_2"
rm "$log_3"
rm -r "$dir"
mkdir "$dir"
mkdir "$dir/1"
mkdir "$dir/2"
mkdir "$dir/3"
mkdir "$dir/4"

dapp build
dapp deploy -c 'Lib_1' -o "$dir/1" >> "$log_1"
dapp deploy -c 'Lib_2' --lib "{{Lib_1, $dir/1/}}" -o "$dir/2" >> "$log_1"
dapp deploy -c 'Lib_3' --lib "{{Lib_2, $dir/2/}}" -O "$dir/3/{{contract}}.deployed.json" >> "$log_1"
dapp deploy -c 'Lib_4' --lib "{{Lib_3, $dir/3/Lib_3.deployed.json}}" -o "$dir/4" >> "$log_1"

dapp deploy -c 'C' --lib "{{Lib_4, $dir/4/}}" --params 'C_1' -o "$dir" >> "$log_2"

dapp deploy -c 'C' --lib "{{Lib_4, $dir/4/}}" --params 'C_1' -o "$dir" --gas '0x3e000' >> "$log_3"
