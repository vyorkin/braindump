+++
title = "Substrate custom tokens"
author = ["Vasiliy Yorkin"]
draft = false
+++

## Overview {#overview}

There are a few ways to launch a token with Substrate.

-   [pallet\_balances](https://paritytech.github.io/substrate/master/pallet%5Fbalances/index.html)
-   [pallet\_assets](https://paritytech.github.io/substrate/master/pallet%5Fassets/index.html)
-   ?


## Balances Pallet {#balances-pallet}


### Overview {#overview}

Manages a single finguble token, handles accounts and their balances.


### Initial balances {#initial-balances}

Supplying initial balances with a genesis config:

```rust
pub fn genesis_config(...) -> GenesisConfig {
    // ...
    GenesisConfig {
        // ...
        balances: runtime::BalancesConfig {
            balances: vec![
                // (AccountId, Balance)
                // ...
            ],
        },
        // ...
    }
}
```


### Transaction fees {#transaction-fees}

Normally, transaction fees are paid with this pallet's accounts.

```nil
fee = base_fee + byte_fee * length + weight_fee
```


#### Details {#details}

This is implemented in the [pallet\_transaction\_payment](https://paritytech.github.io/substrate/master/pallet%5Ftransaction%5Fpayment/index.html) and could
be configured in the Runtime like this:

```rust
parameter_types! {
    // Per-byte fee.
    pub const TransactionByteFee: u128 = 1 * MICRO_LUN;

    // Fee multiplier for operational extrinsics.
    pub const OperationalFeeMultiplier: u8 = 5;
}

impl pallet_transaction_payment::Config for Runtime {
    // Handler for withdrawing, refunding and depositing the transaction fee.
    // Transaction fees are withdrawn before the transaction is executed.
    // After the transaction was executed the transaction weight can be
    // adjusted, depending on the used resources by the transaction. If the
    // transaction weight is lower than expected, parts of the transaction fee
    // might be refunded. In the end the fees can be deposited.
    //
    // Basically, here we're saying that we want to charge fees from balances pallet.
    type OnChargeTransaction = pallet_transaction_payment::CurrencyAdapter<Balances, ()>;

    // The fee to be paid for making a transaction; the per-byte portion.
    type TransactionByteFee = TransactionByteFee;

    // Convert a weight value into a deductible fee based on the currency type.
    type WeightToFee = IdentityFee<Balance>;

    // Update the multiplier of the next block, based on the previous block's weight.
    type FeeMultiplierUpdate = ();

    // A fee mulitplier for `Operational` extrinsics to
    // compute "virtual tip" to boost their `priority`.
    type OperationalFeeMultiplier = OperationalFeeMultiplier;
}
```


## Assets Pallet {#assets-pallet}

Allows to have multiple fungible tokens. Provides a simple asset
management functinality, without extra features like locking.

You can manage assets with the Polkadot UI -- there is an
`Assets` menu item (under `Network`).


### Observations {#observations}

1.  Looks like craation of assets and transfering works from the
    UI
2.  Calling `transfer` or `transferKeepAlive` from the extrinsics
    panel doesn't change the `assets.balances` state.
3.  I'm unable to explore the related event internals due to
    [polkadot
    UI bug](https://github.com/polkadot-js/apps/issues/6468)


## References {#references}

-   [Six ways to launch a token on Substrate](https://www.youtube.com/watch?v=7qkqEfToH8w&ab%5Fchannel=ParityTechnologies) (youtube video)
    -   There is no `GenericAsset` in `substrate > 2.x` anymore
