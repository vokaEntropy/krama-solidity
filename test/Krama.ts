import { expect } from "chai";
import { ethers } from "hardhat";

describe("Krama", () => {
  let acc1: any;
  let acc2: any;
  let krama: any;

  beforeEach(async () => {
    [acc1, acc2] = await ethers.getSigners();
    const Krama = await ethers.getContractFactory("Krama", acc1);
    krama = await Krama.deploy()
    await krama.deployed()
  });

  it("Should be deployed", async () => {
    expect(krama.address).to.be.properAddress
  })

  it("Default balance = 0", async () => {
    const balance = await krama.getBalance()
    expect(balance).to.eq(0)
  })

  it("Send funds", async () => {
    const txAmount = 42
    const tx = await krama.connect(acc2).sendMoney({value: txAmount})

    await tx.wait()
    await expect(() => tx).to.changeEtherBalances([acc2, krama], [-txAmount, txAmount])
  })
});
