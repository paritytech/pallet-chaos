# Chaos Pallet

The Chaos module is used to inject chaos into a Substrate Runtime and intentionally break things.

## Overview

The Chaos module provides functions for:

- Make Substrate Runtimes behave in ways that they're not supposed to.
- Explore Runtime edge cases.
- Explore Extrinsic weights and their economic implications.
- Expose Runtime Attack Vectors.

### Terminology

- **Block Dragger:** an expensive Dispatch call specifically designed to drag down Block production on the Runtime.
- **Weight Damper**: a property of Block Draggers. Consists of a floating point multiplier (`0.0 < wd < 1.0`) for Dispatch weights.

### Implementations

The Chaos module provides implementations for the following traits. If these traits provide the functionality that you need, then you can avoid coupling with the Chaos module.

- `Block Dragger`: Functions for dragging down Block production.

## Interface

### Dispatchable Functions

- `dragBlockUnitWeight(n)` - Drag block production by calculating hashes in a loop (`n` times), with constant unitary weight.
- `dragBlockDampWeight(n, wd)` - Drag block production by calculating hashes in a loop (`n` times), with linear damping on weight (`0.0 < wd < 1.0`). (ToDo)

![block dragger](blockdragger.png)

## Usage

The following commands will set up a local test environment based on:
- [substrate-node-template](https://github.com/substrate-developer-hub/substrate-node-template)
- [pallet-chaos](https://github.com/paritytech/pallet-chaos)

```sh
$ bash < <(curl -s https://raw.githubusercontent.com/paritytech/pallet-chaos/master/test_setup.sh?token=ACJ7XNG3S4IEYGHH6ND5R6TBSCOCO)
```

### Dragging Blocks

Start the chain:
```sh
$ ./target/release/node-template --dev --tmp
```

On PolkadotJS, connect to `DEVELOPMENT` Chain (`ws://127.0.0.1:9944`).

Open `Developer`->`Extrinsics`. Choose `chaos`->`dragBlockUnitWeight(n)`.

Here's where the experimentation starts. Choose different values for `n`, call `Submit Transaction` and observe the effects on block production.

## Roadmap

- [x] `dragBlockUnitWeight` extrinsic implementation
- [ ] `dragBlockDampWeight` extrinsic implementation
- [ ] Block Dragger Trait implementation
- [ ] Empirical Observations (automated via [`chaoscope`](https://github.com/paritytech/chaoscope) RPC calls)

# License
AGPL-3.0
