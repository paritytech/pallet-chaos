#!/bin/bash

SUBSTRATE_V="3.0.0"
SUBSTRATE_TIMESTAMP="monthly-2021-10"

echo ""
echo "   🅂⒰𝕭𝓼ṪᴙȺՇ乇"
echo "       _"
echo "      ⇖⇑⇗"
echo "      ⇐●⇒"
echo "      ⇙⇓⇘"
echo "       ‾"
echo "     ȻнД⓿丂"
echo ""
echo "⚠️Expect... Chaos! ⚠"
echo ""
echo "Our local setup will be based on:"
echo " - [substrate-node-template](https://github.com/substrate-developer-hub/substrate-node-template)"
echo " - [pallet-chaos](https://github.com/paritytech/pallet-chaos)"

echo ""
echo "Let's clone substrate-node-template..."

rm -rf substrate-node-template
git clone https://github.com/substrate-developer-hub/substrate-node-template -b v${SUBSTRATE_V}+${SUBSTRATE_TIMESTAMP} substrate-node-chaos
pushd substrate-node-chaos

echo ""
echo "Let's clone pallet-chaos..."
pushd pallets
git clone ssh://git@github.com/paritytech/pallet-chaos.git
popd

echo ""
echo "Let's add pallet-chaos to the runtime..."
git apply pallets/pallet-chaos/diff/add_chaos_runtime.diff

echo ""
echo "Let's build the node-template executable..."
cargo build --release -j7

echo ""
echo "Let's start the node-template executable..."
echo "From now on, you should turn to [chaoscope](https://github.com/paritytech/chaoscope) for RPC instrumentation."
./target/release/node-template --dev --tmp



