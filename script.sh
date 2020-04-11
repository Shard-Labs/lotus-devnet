#!/bin/bash

nohup ./lotus daemon --lotus-make-random-genesis=dev.gen --genesis-presealed-sectors=~/.genesis-sectors/pre-seal-t0101.json --bootstrap=false &
sleep 5
pkill lotus
sleep 1
rm -rf /root/.lotus
mv /lotusTemp /root/.lotus
nohup ./lotus daemon --lotus-make-random-genesis=dev.gen --genesis-presealed-sectors=~/.genesis-sectors/pre-seal-t0101.json --bootstrap=false &
sleep 5
./lotus-storage-miner init --genesis-miner --actor=t0101 --sector-size=1024 --pre-sealed-sectors=~/.genesis-sectors --pre-sealed-metadata=~/.genesis-sectors/pre-seal-t0101.json --nosync
./lotus-storage-miner run --nosync