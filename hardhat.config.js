require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.10",
  networks: {
    sepolia: {
      url: "https://eth-sepolia.public.blastapi.io",
      accounts: ["2a442a5aea064e8f9b00ae0069dd857355a9b37682d61e82151118007c3d6b66"]
    }
  }
};
