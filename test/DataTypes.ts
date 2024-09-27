import {
    loadFixture
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";

describe("DataTypes", function () {

    async function deployFixture() {
        const [owner, otherAccount] = await hre.ethers.getSigners();
        const DataTypes = await hre.ethers.getContractFactory("DataTypes");
        const dataTypes = await DataTypes.deploy();
        return { dataTypes,  owner, otherAccount };
    }

    describe("Tests operations", function () {
        it("Should print bool types with operations", async function () {
            const { dataTypes, owner, otherAccount } = await loadFixture(deployFixture);
            await expect(dataTypes.printBoolOperation()).to.not.be.reverted
            await expect(dataTypes.printIntegerOperations()).to.not.be.reverted
            await expect(dataTypes.printFloatingOperations(1234, 1212)).to.not.be.reverted
            await expect(dataTypes.printAddressOperations(owner.address)).to.not.be.reverted
        });


    });

});
