// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract VulnerableBank {
    mapping(address => uint256) public balances;

    receive() external payable {}

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed.");
        
        if (balances[msg.sender] >= amount) {
            balances[msg.sender] -= amount;
        } else {
            balances[msg.sender] = 0;
        }
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
