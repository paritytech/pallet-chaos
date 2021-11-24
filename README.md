# Chaos Pallet

The Chaos module is used to inject chaos into a Substrate Runtime and intentionally break things.

## Overview

The Chaos module provides functions for:

- Make Substrate Runtimes behave in ways that they're not supposed to.
- Explore Runtime edge cases.
- Explore Extrinsic weights and their economic implications.
- Expose Runtime Attack Vectors.

### Terminology

- **Block Dragger:** an expensive extrinsic specifically designed to drag down Block production on the Runtime (`drag_block_*`).

## Interface

## Dispatchable Functions

- `dragBlockUnitWeight(n)` - Drags block production by calculating hashes in a loop (`n` times), with constant unitary weight.
- `dragBlockConstantWeight(n, c)` - Drags block production by calculating hashes in a loop (`n` times), with custom constant weight.

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
