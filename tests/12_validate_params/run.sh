#!/usr/bin/env bash

dapp build
dapp deploy -c 'Storage' --params 1 255 '0x100' '0x1111111111222222222233333333334444444444' 'hello world'

command -v 'dapp-console' >/dev/null 2>&1 || exit 0;

dapp console -i './js/script.js' >> 'run.log'
