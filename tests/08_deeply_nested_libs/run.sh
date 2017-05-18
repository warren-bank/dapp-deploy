#!/usr/bin/env bash

dapp build
dapp deploy > '1_run_with_gas_estimate.log'
dapp deploy --gas '0x3e000' > '2_run_with_additional_gas_via_flag.log'
