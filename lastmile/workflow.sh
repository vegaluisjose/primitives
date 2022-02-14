#!/bin/bash

set -e
set -u
set -o pipefail

data=(16)
size=(8 16 32 64 128 256 512 1024 2048)
ram=(a b)

cargo build --release

for s in ${size[@]}; do
	for d in ${data[@]}; do
		for r in ${ram[@]}; do
			cargo run --bin generate -- -r $r -s $s -d $d -o rom.v
			cargo run --bin compile -- -i rom.v
			cargo run --bin parse -- -o ./data/rom${r}_d${d}_s${s}.json
			cargo run --bin generate -- -r $r -s $s -d $d --bram -o rom.v
			cargo run --bin compile -- -i rom.v
			cargo run --bin parse -- -o ./data/rom${r}_bram_d${d}_s${s}.json
		done
	done
done

rm -f rom.v timing.rpt util.rpt
