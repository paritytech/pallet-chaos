# Chaos Pallet

The Chaos module is used to inject chaos into a Substrate Runtime and intentionally break things.

## Overview

The Chaos module provides functions for:

- Make Substrate Runtimes behave in ways that they're not supposed to.
- Explore Runtime edge cases.
- Explore Extrinsic weights and their economic implications.
- Expose Runtime Attack Vectors.

## Interface

## Dispatchable Functions

- `dragBlockUnitWeight(n)` - Injects a heavy computation payload into the runtime, effectively dragging block production by calculating hashes in a loop (n times), with constant unitary extrinsic weight.

![block dragger](blockdragger.png)

### Dragging Blocks

Include `pallet-chaos` to a `substrate-node-template`, build it, and start the chain:
```sh
$ ./target/release/node-template --dev --tmp
```

On PolkadotJS, connect to `DEVELOPMENT` Chain (`ws://127.0.0.1:9944`).

Open `Developer`->`Extrinsics`. Choose `chaos`->`dragBlockUnitWeight(n)`.

Here's where the experimentation starts. Choose different values for `n`, call `Submit Transaction` and observe the effects on block production.

# License
AGPL-3.0
