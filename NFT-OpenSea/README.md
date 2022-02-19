# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```


## first command 
npx hardhat  to create basic project;
## Used this simple code of openZeppelin to create NFT
https://docs.openzeppelin.com/contracts/4.x/erc721

# Import contract 
npm install @openzeppelin/contracts
# Import this for deploy contract 
npm i hardhat-deploy 
# to check the conde is complile and deployment file
npx hardhat compile

# make changes in hardhat.config.js file to intracte with test Ethere network
# https://ethereum.org/en/developers/tutorials/how-to-write-and-deploy-an-nft/
npm install --save-dev @nomiclabs/hardhat-ethers ethers@^5.0.0

# to use shortcut in hardhat install module 
npm i --save hardhat-shorthand


# Verity cond on etherScan we need to install this module 
npm install --save-dev @nomiclabs/hardhat-etherscan
# and also required etherescan account and get key form their



# Code simple repo
https://github.com/PatrickAlphaC/all-on-chain-generated-nft