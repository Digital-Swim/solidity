import {
    loadFixture
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";


async function deployFixture() {

    const { ethers } = hre;

    const [owner, otherAccount] = await ethers.getSigners();

    const BasicNFT = await ethers.getContractFactory("BasicNFT", owner);
    const basicNFT = await BasicNFT.deploy(owner.address);

    const ExtendedNFTASObject = await ethers.getContractFactory("ExtendedNFTAsObject", owner);
    const extendedNFT = await ExtendedNFTASObject.deploy(basicNFT.getAddress());

    return { extendedNFT, owner, otherAccount, basicNFT };
}

describe("Extended NFT", function () {
    it("should mint and transfer NFT with owner validations ", async function () {
        const { ethers } = hre;
        const { extendedNFT, basicNFT, owner, otherAccount } = await loadFixture(deployFixture);

    });
});