#!/usr/bin/env bash

dapp build
dapp deploy -c 'MetaCoin' -q -l 'TestLib=0xc1a094ed2be97e34af194c730fd7e2ccfa68329d' > 'run.log'
