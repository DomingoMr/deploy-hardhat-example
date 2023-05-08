require("@nomicfoundation/hardhat-toolbox");
require("hardhat-deploy");

const GOERLI_URL = process.env.GOERLI_URL
const GOERLI_DEPLOYER_PRIVATE_KEY = process.env.GOERLI_DEPLOYER_PRIVATE_KEY
const GOERLI_USER_PRIVATE_KEY = process.env.GOERLI_USER_PRIVATE_KEY
const SEPOLIA_URL = process.env.SEPOLIA_URL
const SEPOLIA_DEPLOYER_PRIVATE_KEY = process.env.SEPOLIA_DEPLOYER_PRIVATE_KEY
const SEPOLIA_USER_PRIVATE_KEY = process.env.SEPOLIA_USER_PRIVATE_KEY

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",

  defaultNetwork: "hardhat",

  networks: {

    goerli: {
      url: GOERLI_URL,
      accounts: [GOERLI_DEPLOYER_PRIVATE_KEY,
        GOERLI_USER_PRIVATE_KEY],
      chainId: 5
    },

    sepolia: {
      url: SEPOLIA_URL, 
      accounts: [SEPOLIA_DEPLOYER_PRIVATE_KEY,
        SEPOLIA_USER_PRIVATE_KEY],
      chainId: 11155111
    }
  },

  namedAccounts: {
    deployer: {
      default: 0,
      5: 0,
      11155111: 1
    },
    user: {
      default: 1,
      5: 1,
      11155111: 0
    }
  }
};
