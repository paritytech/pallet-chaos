# Chaos Pallet

The Chaos module is used to inject chaos into a Substrate Runtime and intentionally break things.

## Overview

The Chaos module provides functions for:

- Make Substrate Runtimes behave in ways that they're not supposed to.
- Explore Runtime edge cases.
- Explore Extrinsic weights and their economic implications.
- Expose Runtime Attack Vectors.

## Dispatchable Functions

### `unwrap_add`

Inspired by [`unwrap_is_bad` extrinsic implementation from Alex. Popiak's `how-not-to-build-a-pallet`](https://github.com/apopiak/how-not-to-build-a-pallet/blob/c737f27df5fed367c8e53adc20ed18e2846459e1/pallets/template/src/lib.rs#L193), performs an `unwrap` on the `Adder` storage object. If `Adder` is not set, it introduces an unhandled error into the Runtime.

### `overflow_adder`

Inspired by [overflow extrinsic implementation from Alexander Popiak's `how-not-to-build-a-pallet`](https://github.com/apopiak/how-not-to-build-a-pallet/blob/c737f27df5fed367c8e53adc20ed18e2846459e1/pallets/template/src/lib.rs#L165), performs an unchecked sum over the `Adder` storage object. If the result is above `4_294_967_296`, then `Adder` overflows.

This extrinsic illustrates the importance of using safe operations such as [`checked_add`](https://docs.rs/substrate-primitives/1.0.0/substrate_primitives/struct.U256.html#method.checked_add), [`checked_sub`](https://docs.rs/substrate-primitives/1.0.0/substrate_primitives/struct.U256.html#method.checked_sub) and their variants from [`substrate_primitives::U256`](https://docs.rs/substrate-primitives/1.0.0/substrate_primitives/struct.U256.html).

### `clear_adder`

Simply clears the `Adder` storage object so that `unwrap_add` can illustrate bad unwraps.

### `dragBlockUnitWeight(n)`

Injects a heavy computation payload into the runtime, effectively dragging block production by calculating hashes in a loop (n times), with constant unitary extrinsic weight.

This extrinsic illustrates the importance of proper weight design.

![block dragger](blockdragger.png)

# Usage

[`chaoscope`](https://github.com/paritytech/chaoscope) provides a CLI utility to automate interaction with `pallet-chaos` on a local setup.

1. In case you want to interact with it manually, follow the steps below.
2. Include `pallet-chaos` to a `substrate-node-template`, build it, and start the chain:
```sh
$ ./target/release/node-template --dev --tmp
```
3. On PolkadotJS, connect to `DEVELOPMENT` Chain (`ws://127.0.0.1:9944`).
4. Open `Developer`->`Extrinsics`.

## Bad Unwrapping

Choose `chaos`->`unwrapAdder()`.

If `Adder` is not set on the Runtime Storage, you should see a red ⚠️ sign.

If `Adder` is already set (`overflowAdder(n)` has been called), you can clear it by calling `chaos`->`clearAdder()` and then trying to call `chaos`->`unwrapAdder()` again.

## Overflowing

On a browser new tab, open `Developer`->`Chain state`.
Then choose `chaos`-> `adder()`, and click the `+` sign. This is how you'll monitor the `Adder` storage object.

On the extrinsics tab you had previously open, choose `chaos`->`overflowAdder(n)`.

While monitoring `adder()` on the `Chain state` tab, keep adding numbers at will, until you reach `4_294_967_296`.

Observe what happens after you add above this value, and imagine what would be the implications if `Adder` actually represented something meaningful in your chain.


## Dragging Blocks

Choose `chaos`->`dragBlockUnitWeight(n)`.

Here's where the experimentation starts. Choose different values for `n`, call `Submit Transaction` and observe the effects on block production.

# License
AGPL-3.0
