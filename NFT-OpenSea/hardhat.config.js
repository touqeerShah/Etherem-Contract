require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");
require('hardhat-deploy');
require('dotenv').config();

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
const {
  API_URL,
  PRIVATE_KEY,
  ETHERSCANAPIKEY,
  MOMONIUME,
  API_URL_RENKEBY
} = process.env;
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */

module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {},
    ropsten: {
      url: API_URL,
      // accounts:{
      //   mnemonic:MOMONIUME
      // }
      accounts: [`${PRIVATE_KEY}`]
    },
    rinkeby: {
      url: API_URL_RENKEBY,
      // accounts:{
      //   mnemonic:MOMONIUME
      // }
      accounts: [`${PRIVATE_KEY}`]
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: ETHERSCANAPIKEY
  },
  solidity: {
    compilers: [{
      version: "0.8.4"
    },{
      version: "0.4.24"
    },{
      version: "0.6.6"
    },{
      version: "0.7.0"
    }]
  },
  namedAccounts: {
    deployer: {
      default: 0
    }
  }
};