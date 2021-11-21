use super::*;

#[allow(unused)]
use crate::Pallet as Template;
use frame_benchmarking::{account, benchmarks, whitelisted_caller};
use frame_system::RawOrigin;

benchmarks! {
	drag_block_unit_weight {
		let caller = whitelisted_caller();
		let n in 1 .. 10_000_000;
	}: drag_block_unit_weight(RawOrigin::Signed(caller), n.into())
	verify {
		assert_eq!(1, 1)
	}

	drag_block_constant_weight {
		let caller = whitelisted_caller();
		let n in 1 .. 10_000_000;
		let c in 1 .. 10_000_000;
	}: drag_block_constant_weight(RawOrigin::Signed(caller), n.into(), c.into())
	verify {
		assert_eq!(1, 1)
	}
}
