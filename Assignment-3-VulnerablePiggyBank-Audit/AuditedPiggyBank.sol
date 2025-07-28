// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuditedPiggyBank {
    address public owner;

    // Constructor sets the deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    // Fallback function to accept Ether
    receive() external payable {}

    // Anyone can check the balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Fixed withdraw function - Only owner can withdraw funds
    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw!");
        payable(msg.sender).transfer(address(this).balance);
    }

    // Dummy attack function for demonstration only
    function attack() public {
        // Does nothing; previously could have been used to exploit
    }
}
