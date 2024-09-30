// SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.20;

import "./BasicNFT.sol";

contract ExtendedNFTAsObject {

    BasicNFT private basicNFT;

    constructor(address _basicNFTAddress) {
        // Initialize the BasicNFT contract instance using its address
        basicNFT = BasicNFT(_basicNFTAddress);
    }

    // Function to interact with the BasicNFT contract to mint an NFT
    function mintNFTFromBasic(address recipient) public {
        // Only the owner of BasicNFT can call mintNFT
        basicNFT.mintNFT(recipient);
    }

    // Function to get the address of the BasicNFT contract
    function getBasicNFTAddress() public view returns(address) {
        return address(basicNFT);
    }

    // Function to get the total number of tokens minted in BasicNFT
    function getBasicNFTTokenCounter() public view returns(uint256) {
        return basicNFT.tokenCounter();
    }

    // Function to get the owner of a specific token from BasicNFT
    function getTokenOwner(uint256 tokenId) public view returns(address) {
        return basicNFT.ownerOf(tokenId);
    }
}
