# 🛡️ Assignment 3 – Smart Contract Security Audit

This assignment is part of my fellowship program at Dev3Pack. It was created to help me understand and revise key security concepts in Solidity, especially around **access control vulnerabilities**.

---

## 🕵️ What's Wrong?

### ❌ The `withdraw()` function is vulnerable

```solidity
function withdraw() public {
    payable(msg.sender).transfer(address(this).balance);
}
```

### 🔍 What it does:
It sends **all funds** in the contract to **whoever calls this function**.

### ⚠️ What's the problem:
It doesn’t check whether the caller is the **owner**.  
So, **anyone** can drain all the funds — not just the person who deployed the contract!

---

## ✅ The Fix: Add an Owner Check

We need to ensure that **only the owner** can withdraw the funds.

### 🔐 Secure Version:

```solidity
function withdraw() public {
    require(msg.sender == owner, "Only owner can withdraw!");
    payable(msg.sender).transfer(address(this).balance);
}
```

### 🔒 What this line does:
```solidity
require(msg.sender == owner, "Only owner can withdraw!");
```

It makes sure that **only the owner (deployer)** can withdraw funds.

If **anyone else** tries to call it, the function **reverts** with the error message:  
> "Only owner can withdraw!"

---

## 🛠️ Constructor (Already Present)

```solidity
constructor() {
    owner = msg.sender;
}
```

This sets the deployer of the contract as the **owner** when it is deployed.

---

## 💣 About the `attack()` Function

In the original contract:

```solidity
function attack() public { }
```

This function currently **does nothing**, but it hints at the idea of how an attacker **could** deploy a malicious contract that calls `withdraw()` to **drain the funds** — **if** the owner check wasn’t added.

With the fix (`require(msg.sender == owner)`), this kind of attack **won’t work anymore**.

---

## 📁 Files

- [`AuditedPiggyBank.sol`](./AuditedPiggyBank.sol): Fixed version of the contract with proper owner check.
- [`README.md`](./README.md): This file you're reading, explaining the vulnerability and the resolution.

---

## ✅ Final Thoughts

This assignment helped me understand how a **small access control mistake** can make a smart contract extremely vulnerable.

Whenever you write a function that handles **Ether or sensitive operations**, you should:

- Add access control with `require(msg.sender == owner)`  
  **or**
- Use proper **modifiers** like `onlyOwner`

Simple checks save your contract from big hacks.

---

