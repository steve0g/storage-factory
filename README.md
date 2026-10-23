# Storage Factory — Practice

Practice exercises for the Storage Factory section of the Solidity Smart Contract Development course (Cyfrin Updraft). One file per lesson, written without a solution to consolidate my understanding.

## Exercises

- `01-deploy-from-contract.sol` — A factory contract that deploys new counter contracts with `new` and keeps track of them in an array.
- `05-factory-owner.sol` — A factory that creates stock contracts and passes the caller's address to the constructor, so each stock belongs to the right owner.
- `02-imports-base.sol` — A small `Calculatrice` contract with a pure `doubler` function, meant to be imported.
- `02-imports.sol` — A contract that imports `Calculatrice` by name, creates it with `new` and calls it.
- `03-interacting-abi.sol` — A supervisor contract that creates gauge contracts, calls functions on them by array index, and reads their address.

More exercises (imports, ABI interaction, inheritance) will be added as I complete them.