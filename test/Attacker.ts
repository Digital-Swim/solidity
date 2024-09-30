import {
    loadFixture
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";


async function deployFixture() {

    const { ethers } = hre;

    const [owner, attackerAccount] = await ethers.getSigners();

    const VulnerableBank = await ethers.getContractFactory("VulnerableBank", owner);
    const vulnerableBank = await VulnerableBank.deploy();
    const vulnerableBankAddress = await vulnerableBank.getAddress();

    const Attacker = await ethers.getContractFactory("Attacker", attackerAccount);
    const attacker = await Attacker.deploy(vulnerableBankAddress);

    await owner.sendTransaction({
        to: vulnerableBankAddress,
        value: ethers.parseEther("10")
    });

    expect(await hre.ethers.provider.getBalance(vulnerableBankAddress)).to.equal(
        ethers.parseEther("10")
    );

    return { vulnerableBank, vulnerableBankAddress, attacker, owner, attackerAccount };
}

describe("VulnerableBank", function () {
    it("should be vulnerable to reentrancy attack", async function () {
        const { ethers } = hre;
        const { vulnerableBank, attacker, owner, vulnerableBankAddress, attackerAccount } = await loadFixture(deployFixture);

        expect(await hre.ethers.provider.getBalance(vulnerableBankAddress)).to.equal(
            ethers.parseEther("10")
        );

        await expect(attacker.connect(attackerAccount).attack({ value: ethers.parseEther("1") })).to.not.be.reverted;

        const vulnerableBalance = await ethers.provider.getBalance(vulnerableBankAddress);
        console.log("Vulnerable Bank Balance after attack: ", vulnerableBalance.toString());

        // Check the balance of the attacker contract after the attack
        const attackerBalance = await ethers.provider.getBalance(attacker.getAddress());
        console.log("Attacker Contract Balance after attack: ", attackerBalance.toString());

        // Attacker should have drained more than 1 Ether from the vulnerable contract
        expect(vulnerableBalance).to.be.lt(ethers.parseEther("9"));

    });
});