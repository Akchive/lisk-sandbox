// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./VaultBase.sol";
import "./SafeMath.sol";

contract VaultManager is VaultBase {
    using SafeMath for uint;

    function deposit() public payable {
        require(msg.value > 0, "Deposit must be more than 0");
        balances[msg.sender] = balances[msg.sender].add(msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint amount) public {
        require(amount > 0, "Withdraw must be more than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] = balances[msg.sender].sub(amount);
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }
}
