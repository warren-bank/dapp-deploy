#!/usr/bin/env bash

dapp build
dapp deploy -c 'C_1' > 'run.log'
dapp deploy -c 'C_2' --params '{{C_1}}' >> 'run.log'
dapp deploy -c 'C_3' --params '{{C_2}}' >> 'run.log'

command -v 'dapp-console' >/dev/null 2>&1 || exit 0;

dapp console -i './js/script_1.js' >> 'run.log'
