#!/usr/bin/env bash

names='["a","b","c"]'
values='[1,2,3]'

dapp build
dapp deploy -c 'C' --params $names $values > 'run.log'
