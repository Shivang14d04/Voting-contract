# Ballot – Voting Smart Contract

A Solidity smart contract that implements a decentralized and transparent voting system with support for vote delegation. The chairperson can create proposals, grant voting rights, and voters can either cast their vote directly or delegate their voting power to another voter. All votes are counted on-chain, and the winning proposal can be retrieved at any time.

## Features

- Chairperson-managed proposal creation.
- Granting of voting rights to specific addresses.
- Direct voting and vote delegation.
- Automatic on-chain vote counting.
- Retrieval of winning proposal and its index.

## Contract Overview

- **Chairperson**: The account that deploys the contract, creates proposals, and gives voting rights.
- **Proposals**: Created at deployment, each has a name and vote count.
- **Voters**: Can vote directly or delegate their vote to another voter.

## Functions

- `giveRightToVote(address voter)` – Grants voting rights to a specified address.
- `vote(uint proposalIndex)` – Casts a vote for a proposal.
- `delegate(address to)` – Delegates voting rights to another voter.
- `FindWinner()` – Returns the index of the winning proposal.
- `WinningProposal()` – Returns the name of the winning proposal.

## Deployment (Remix IDE)

1. Open [Remix IDE](https://remix.ethereum.org/).
2. Create a new file `Ballot.sol` and paste the contract code.
3. Compile using Solidity version `0.8.25` (or compatible).
4. Deploy the contract, passing an array of proposal names (e.g., `["Alice","Bob","Charlie"]`).

## Interaction (Remix IDE)

1. As the **chairperson** (deployer), call `giveRightToVote()` for each voter.
2. Voters call `vote()` with the proposal index, or `delegate()` to assign their vote to someone else.
3. Call `WinningProposal()` to see the current winner.

## License

This project is licensed under the MIT License.
