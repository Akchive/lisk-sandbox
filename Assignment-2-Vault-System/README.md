# 🛡️ Simple Vault System - Assignment 2 (Week 2 Lecture 1)

This project implements a basic **Vault system** using Solidity, as part of the Smart Contract Development course. The system allows users to **deposit and withdraw Ether** with proper safety checks.

## ✅ Requirements Covered

- ✅ Use a **Math library** for arithmetic operations.
- ✅ Emit **Events** on deposit and withdrawal.
- ✅ Use `require()`/`revert()` for error handling.
- ✅ Use **Inheritance**:
  - `VaultBase`: base contract for shared logic and data structures.
  - `VaultManager`: derived contract for deposit and withdraw functionalities.

---

## 📂 File Structure

```bash
.
├── contracts/
│   ├── MathLib.sol
│   ├── VaultBase.sol
│   └── VaultManager.sol
├── README.md
└── ...

---

## 🚀 Deployment Instructions

These are the exact steps followed to deploy this contract successfully:

### 1. Generate wallets
```bash
yarn generate
```
> This will generate burner wallets and show the address you'll be using. Fund this address on Sepolia using a faucet.

---

### 2. Check account details
```bash
yarn account
```
> Make sure your account has ETH before deploying!

---

### 3. Deploy the contract
```bash
yarn deploy --network sepolia
```

---

### 4. Verify contract on Etherscan
```bash
yarn verify --network sepolia
```

---

### 5. Deploy frontend
```bash
yarn vercel --network sepolia
```

> ✅ Don’t forget to **update the target network** in `packages/nextjs/scaffold.config.ts`:
```ts
targetNetwork: chain.sepolia,
```

---

## 🧠 Smart Contract: `VaultManager.sol`

This contract has two main functions:

### 🔐 `deposit()`
- Users can deposit ETH.
- Uses `require(msg.value > 0)` to prevent depositing **0 ETH**.
- Emits a `Deposit` event on success.

```solidity
function deposit() external payable {
    require(msg.value > 0, "Deposit must be more than 0");
    balances[msg.sender] += msg.value;
    emit Deposit(msg.sender, msg.value);
}
```

#### ✅ Error handling added:
> If user tries to deposit 0 ETH, the transaction reverts with:
```bash
revert: Deposit must be more than 0
```
This ensures no useless/pending 0 ETH transactions go through.

---

### 💸 `withdraw(uint amount)`
- Allows users to withdraw ETH **up to their balance**.
- Uses:
```solidity
require(balances[msg.sender] >= amount, "Insufficient balance");
```
- Sends ETH via `call`.

#### ✅ Error handling:
> If user tries to withdraw more than their balance, it reverts with:
```bash
revert: Insufficient balance
```

---

## 💥 Errors I Faced (and How I Fixed Them)

### 🔴 Problem: Red `Deposit` button caused transaction to revert
- When trying to deposit `0 ETH`, the frontend didn't stop the user.
- Solution: Added `require(msg.value > 0)` to smart contract to enforce it.

### 🔴 Problem: Nothing showed up in the frontend
- Didn’t deposit anything, so balances appeared empty.
- ✅ Once 1 ETH was deposited, `getBalance()` started returning expected values.

### ✅ Fixed by:
- Making sure ETH > 0 is passed
- Listening to events using the Scaffold-ETH UI
- Making test transactions on Sepolia

---

## ✅ Final Notes for Submission

- Contract Name: `VaultManager`
- Events Used: `Deposit`, `Withdraw`
- State Variable: `mapping(address => uint) public balances;`
- Prevented 0 ETH deposits & over-withdrawing
- Interacted successfully using Scaffold-ETH frontend

---

## 📸 Screenshot

<img width="1899" height="898" alt="Screenshot (121)" src="https://github.com/user-attachments/assets/adb24b22-18e6-4d63-9dd9-7d8b03cb1638" />
<img width="1914" height="891" alt="Screenshot (124)" src="https://github.com/user-attachments/assets/95286752-9c96-46d1-82b9-29d29e7b2e82" />


