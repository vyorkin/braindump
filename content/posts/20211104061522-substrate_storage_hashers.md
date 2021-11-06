+++
title = "Substrate storage hashers"
author = ["Vasiliy Yorkin"]
draft = false
+++

## `blake2_128_concat` {#blake2-128-concat}

Cryptographically secure hash function.

Choose this hasher if users of your chain have the ability to
affect the storage keys.


## `twox_64_concat` {#twox-64-concat}

Not cryptographically secure, but is more efficient than `blake2`.
You should not use this hasher if chain users can affect the storage key.
However, it is perfectly safe to use this hasher to gain performance in scenarios where the users do not control the keys.


## `identity` {#identity}

Identity function that returns the same value it receives. This
hasher is only an option when the key type in your storage map
is already a hash, and is not controllable by the user.
