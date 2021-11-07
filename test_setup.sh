#!/bin/bash

SUBSTRATE_V="3.0.0"
SUBSTRATE_TIMESTAMP="monthly-2021-10"
SUBSTRATE_NODE_TEMPLATE_URL="https://github.com/substrate-developer-hub/substrate-node-template/archive/refs/tags/v${SUBSTRATE_V}+${SUBSTRATE_TIMESTAMP}.tar.gz"

echo "                         SuBsTrAtE"
echo "                             _
                          α␡%:ωɚʵ
                      α␡%:       :ωɚʵ
        ΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑAA     ΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑAA
        ɀɀ      :ωɚʵ     ɀɀ     ɀɀ     α␡%:      ɀɀ
        ɀɀɀɀɀɀɀ     :ωɚʵ ɀɀ     ɀɀ α␡%:     ɀɀɀɀɀɀɀ
      _ʘɀɀ     :ωɚʵ     ɀɀɀ     ɀɀɀ     α␡%:     ɀɀʘ_
  α␡%:  ΩΩΩΩΩΩΩΩΩΩΩΩΩΩ               ΩΩΩΩΩΩΩΩΩΩΩΩΩΩ  :ωɚʵ
:ωɚʵ                                                   α␡%:
  :ωɚʵ  ΩΩΩΩΩΩΩΩΩΩΩΩΩΩ               ΩΩΩΩΩΩΩΩΩΩΩΩΩΩ  α␡%:
      :ʘɀɀ     α␡%:     ɀɀɀ     ɀɀɀ     :ωɚʵ     ɀɀʘ:
        ɀɀ:ɀɀɀ:       α␡%:8     ɀɀωɚʵ     :ɀɀɀ␡%:ɀɀ
        ɀɀ        α␡%:   ɀɀ     ɀɀ   :ωɚʵ        ɀɀ
        ΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑAA     ΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑAA
                      :ωɚʵ       α␡%:
                          :ɀɀαɀɀ:
                             _
                           ChA0S
                             "
echo "We're about to break some chains! Our local setup will be based on:"
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
echo "Let's build the node-chaos executable:q:q..."
cargo build --release

echo ""
echo "Let's start the node-chaos executable"
./target/release/node-template --dev --tmp



