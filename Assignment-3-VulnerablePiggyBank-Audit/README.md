# Assignment 3 – Vulnerability Fix & Smart Contract Audit

This repository is part of my fellowship at **Dev3Pack**, created to help me learn and revise how to identify and fix vulnerabilities in smart contracts.

---

## 🧾 Original Assignment

> Identify and fix the vulnerabilities in this simple smart contract to make it secure.  
> Add your custom attack function to attack the smart contract and call the withdraw function.  
> Submit the repo link to your audited source code.

---

## 🔓 Original Vulnerable Contract (`VulnerablePiggyBank.sol`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerablePiggyBank {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {}

    function withdraw() public {
        payable(msg.sender).transfer(address(this).balance);
    }

    function attack() public {}
}
```

---

## 🕵️ What's Wrong?

### ❌ The `withdraw()` function is vulnerable

```solidity
function withdraw() public {
    payable(msg.sender).transfer(address(this).balance);
}
```

**What it does:**  
It sends all the funds in the contract to whoever calls this function.

**What's the problem:**  
There is **no check** to confirm whether the caller is the owner of the contract.

This means **anyone** can call `withdraw()` and steal all the ETH from the contract.

---

## ✅ The Fix – Add an Owner Check

To fix this, we need to make sure that **only the owner** can withdraw the funds.

### 🔐 Add a `require` statement

```solidity
function withdraw() public {
    require(msg.sender == owner, "Only owner can withdraw!");
    payable(msg.sender).transfer(address(this).balance);
}
```

### Why does this work?

- `msg.sender` is the person calling the function.
- If `msg.sender` is not the same as the stored `owner`, the transaction fails.
- This line acts as an access control gate.

✅ Now, only the deployer (owner) of the contract can withdraw ETH from it.

---

## ⚠️ The `attack()` Function

The original contract included an empty `attack()` function:

```solidity
function attack() public {}
```

Although it's empty, an attacker doesn’t need it. They can create a **separate malicious contract** that simply calls the public `withdraw()` function.

---

## 💣 Simulated Attack (`Attacker.sol`)

Here is an example of how someone could write a malicious contract to exploit the vulnerability:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IVulnerablePiggyBank {
    function withdraw() external;
}

contract Attacker {
    IVulnerablePiggyBank public piggy;

    constructor(address _target) {
        piggy = IVulnerablePiggyBank(_target);
    }

    function attack() public {
        piggy.withdraw(); // This works if there's no owner check!
    }

    receive() external payable {}
}
```

### 🧨 How this works:

- The attacker sets the address of the vulnerable contract.
- When they call `attack()`, it triggers `withdraw()` on the vulnerable contract.
- Since there's no owner restriction, the entire balance is transferred to the attacker.

---

## 🔒 Fixed & Audited Contract (`AuditedPiggyBank.sol`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuditedPiggyBank {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Fallback to accept ETH
    receive() external payable {}

    function deposit() public payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw!");
        payable(msg.sender).transfer(address(this).balance);
    }

    function attack() public {
        // Placeholder only – does nothing
    }
}
```

---

## 🧠 Key Takeaways

- ✅ Always add `require(msg.sender == owner)` in sensitive functions.
- 🚫 Never let public functions transfer contract balance without access control.
- 🛠 Simple access checks prevent major security issues.
- 🔁 Use modifiers like `onlyOwner` (or similar patterns) in bigger contracts.
- 🔍 Review and audit every contract before deploying!

---

## 📁 File Structure

```
Assignment-3-AuditedPiggyBank/
├── README.md                  <-- This explanation file
├── VulnerablePiggyBank.sol   <-- Original vulnerable contract
├── AuditedPiggyBank.sol      <-- Fixed version with proper checks
├── Attacker.sol              <-- Simulated attacker contract
```


