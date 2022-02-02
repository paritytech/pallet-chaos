#![cfg_attr(not(feature = "std"), no_std)]

pub use pallet::*;

#[cfg(test)]
mod mock;

#[cfg(test)]
mod tests;

#[cfg(feature = "runtime-benchmarks")]
mod benchmarking;

#[frame_support::pallet]
pub mod pallet {
	use frame_support::{dispatch::DispatchResult, pallet_prelude::*, sp_runtime::traits::Hash};
	use frame_system::pallet_prelude::*;

	/// Configure the pallet by specifying the parameters and types on which it depends.
	#[pallet::config]
	pub trait Config: frame_system::Config {
		/// Because this pallet emits events, it depends on the runtime's definition of an event.
		type Event: From<Event<Self>> + IsType<<Self as frame_system::Config>::Event>;
	}

	#[pallet::pallet]
	#[pallet::generate_store(pub(super) trait Store)]
	pub struct Pallet<T>(_);

	// The pallet's runtime storage items.
	// https://docs.substrate.io/v3/runtime/storage
	#[pallet::storage]
	#[pallet::getter(fn adder)]
	// Learn more about declaring storage items:
	// https://docs.substrate.io/v3/runtime/storage#declaring-storage-items
	pub type Adder<T> = StorageValue<_, u32>;

	// Pallets use events to inform users when important changes are made.
	// https://docs.substrate.io/v3/runtime/events
	#[pallet::event]
	#[pallet::generate_deposit(pub(super) fn deposit_event)]
	pub enum Event<T: Config> {
		/// Event documentation should end with an array that provides descriptive names for event
		/// parameters. [something, who]
		Stalled(u64, T::AccountId),
		AdderStored(u32, T::AccountId),
	}

	// Errors inform users that something went wrong.
	#[pallet::error]
	pub enum Error<T> {
		/// Error names should be descriptive.
		NoneValue,
		/// Errors should have helpful documentation associated with them.
		StorageOverflow,
	}

	// Dispatchable functions allows users to interact with the pallet and invoke state changes.
	// These functions materialize as "extrinsics", which are often compared to transactions.
	// Dispatchable functions must be annotated with a weight and must return a DispatchResult.
	#[pallet::call]
	impl<T: Config> Pallet<T> {
		// By using the smallest possible weight we are essentially telling
		// the runtime that this dispatchable function will be executed immediately
		#[pallet::weight(1 as Weight)]
		pub fn drag_block_unit_weight(origin: OriginFor<T>, n: u64) -> DispatchResult {
			let who = ensure_signed(origin)?;

			let mut j = 0;

			// stall loop
			for i in 1..=n {
				// hash to waste some cpu cycles
				T::Hashing::hash_of(&j);
				j = i;
			}

			Self::deposit_event(Event::Stalled(n, who));

			// Return a successful DispatchResultWithPostInfo
			Ok(())
		}

		#[pallet::weight(10_000_000 + T::DbWeight::get().reads_writes(1, 1))]
		pub fn overflow_adder(origin: OriginFor<T>, n: u32) -> DispatchResult {
			let who = ensure_signed(origin)?;

			let adder = Adder::<T>::get().unwrap_or(0);

			// we're not checking for an overflow here!
			let adder_new = adder + n;

			// comment below is how we should be doing the addition
			// let adder_new = prev.checked_add(1).ok_or(Error::<T>::Overflow)?;

			Adder::<T>::put(adder_new);

			Self::deposit_event(Event::AdderStored(adder_new, who));
			Ok(())
		}
	}
}
