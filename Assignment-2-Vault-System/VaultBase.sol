// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract VaultBase {
    mapping(address => uint) internal balances;

    event Deposit(address indexed user, uint amount);
    event Withdraw(address indexed user, uint amount);

    function getBalance(address user) public view returns (uint) {
        return balances[user];
    }
}
