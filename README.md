# x402 King of the Hill

An onchain competitive game built on Base.

## Concept

- Last depositor becomes the King
- Timer resets on every new deposit
- If no one replaces you within the time limit → you win the pool

## Mechanics

- 2% builder fee (x402 logic)
- Remaining value goes into the pool
- Winner takes all

## Why?

Exploring:
- Onchain game theory
- Competitive liquidity mechanics
- User-driven activity loops

## How to Play

1. Send ETH to the contract
2. Become the King
3. Stay the last depositor
4. Wait until timer ends
5. Claim the reward

## Deploy

```bash
npm install
npx hardhat compile
npx hardhat run scripts/deploy.js --network base
