+++
title = "Substrate manual/instant sealing"
author = ["Vasiliy Yorkin"]
draft = false
+++

## Rationale {#rationale}

Usually in development environment (for local testing) we want to run as a
standalone blockchain node (not as a parachain) and author
blocks instantly as transactions are received. For that purposes
we have two consensus algrorithms in Substrate: `Manual Seal`
and `Instant Seal`.

The instant seal consensus engine, and its cousin the manual
seal consensus engine, are both included in the same
`sc-consensus-manual-seal` crate.


## Manual seal {#manual-seal}

There is one author and it authors a block whenever you tell it
via an RPC call.


## Instant sealing {#instant-sealing}

There is one author and it attempts to author a block as soon as
it sees a transaction in the pool, most often leading to one
transaction per block. This is perfect for testing and iterating
on a runtime.

This is similar to `Truffle Suite's Ganache` in the Ethereum
ecosystem, but without the UI.


## References {#references}

-   [[<https://www.youtube.com/watch?v=uhkV0jAcWDY&ab%5Fchannel=ParityTechnologies/>[Manual
    Seal and Instant Seal]] - Youtube video
