#!/bin/bash

SUBSTRATE_V="3.0.0"
SUBSTRATE_TIMESTAMP="monthly-2021-10"
SUBSTRATE_NODE_TEMPLATE_URL="https://github.com/substrate-developer-hub/substrate-node-template/archive/refs/tags/v${SUBSTRATE_V}+${SUBSTRATE_TIMESTAMP}.tar.gz"

echo "-----------------------------------------------------------------------"
echo "                      Substrate Chaos"
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
                             "
echo "We will set up a local test environment based on:"
echo " - [substrate-node-template](https://github.com/substrate-developer-hub/substrate-node-template)"
echo " - [pallet-chaos](https://github.com/paritytech/pallet-chaos)"
echo ""

rm -rf substrate-node-template
git clone https://github.com/substrate-developer-hub/substrate-node-template -b v${SUBSTRATE_V}+${SUBSTRATE_TIMESTAMP}

pushd substrate-node-template
pushd pallets
git clone ssh://git@github.com/paritytech/pallet-chaos.git
popd

pwd
git apply pallets/pallet-chaos/diff/add_chaos_runtime.diff
cargo build --release
./target/release/node-template --dev --tmp



