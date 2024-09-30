import {
    loadFixture
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";


async function deployFixture() {

    const { ethers } = hre;

    const [owner, otherAccount] = await ethers.getSigners();

    const ExtendedNFT = await ethers.getContractFactory("ExtendedNFT", owner);
    const extendedNFT = await ExtendedNFT.deploy();

    return { extendedNFT, owner, otherAccount };
}

describe("Extended NFT", function () {
    it("should mint and transfer NFT with owner validations ", async function () {
        const { ethers } = hre;
        const { extendedNFT, owner, otherAccount } = await loadFixture(deployFixture);
        await extendedNFT.mintAndTransfer(otherAccount.address);

        expect(await extendedNFT.owner()).to.equal(owner.address);
        expect(await extendedNFT.owner()).to.equal(owner.address);
        expect(await extendedNFT.ownerOf(0)).to.equal(otherAccount.address);

        // Expecting the Transfer event to be emitted from ExtendedNFT contract address
        await expect(extendedNFT.mintAndTransfer(otherAccount.address)).to.emit(extendedNFT, "Transfer").withArgs(owner.address, otherAccount.address, 1);

        let tx = extendedNFT.mintAndTransfer(otherAccount.address);
        await expect(tx).to.emit(extendedNFT, "Transfer").withArgs(owner.address, otherAccount.address, 2);
        
        
    });
});