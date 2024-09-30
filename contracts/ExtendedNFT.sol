// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BasicNFT.sol";

contract ExtendedNFT is BasicNFT {
    constructor() BasicNFT(msg.sender) {}

    // Mint an NFT to the sender and then transfer it to another address
    function mintAndTransfer(address recipient) public returns (uint256) {
        // Mint an NFT to the caller of this function
        uint256 newTokenId = mintNFT(msg.sender);

        // Internal transaction: Transfer the minted NFT to the recipient
        _transfer(msg.sender, recipient, newTokenId);

        return newTokenId;
    }
    
}
