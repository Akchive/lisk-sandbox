// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//This is the original contract with vulnerabilities. to show what we are auditing and improving.
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
