
const hre = require("hardhat");

const main = async () => {
  const Flashloan = await ethers.deployContract("QuickLoan");
  const flashloan = await Flashloan.waitForDeployment("0x012bAC54348C0E635dCAc9D5FB99f06F24136C9A");

  await flashloan.deployed();
  console.log("Flashloan contract deployed add: ", await flashloan.getAddress())
  
}


const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};
