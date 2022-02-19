const fs = require("fs");
const { exec } = require("child_process");
let {networkConfig} =require("../helper.config.js")
module.exports= async({
    getNamedAccounts,
    deployments,
    getChainId
})=>{

    const { deploy,log} = deployments;
    const { deployer} = await getNamedAccounts();
    const chainId = await getChainId();

    log("--------------------------------");
    log("Deployer Address", deployer);


    log("--------------------------------");
    const contractStorage = await deploy("ContractStorageV1", {
        from: deployer,
        log: true,
        
    })
    log(`ContractStorageV1 contract is deployed on local network to ${contractStorage.address} ${chainId}`);

    const TKSVGToken = await deploy("ContractABC",{
        from: deployer,
        args: [contractStorage.address],

        log: true,
    })
    log(`Your contract is deployed on local network to ${TKSVGToken.address} ${chainId}`);
    const svgContract = await ethers.getContractFactory("ContractABC")
    const accounts = await hre.ethers.getSigners(); // this is hardhat object which will return all the accounts of local networks
    const signer= accounts[0];
    log(`Account Address`,JSON.stringify(signer))
    const svgNFT = new ethers.Contract(TKSVGToken.address,svgContract.interface,signer);

    const networkName= networkConfig[chainId]['name']; // this will help as when we deployed contract on real network it help as to verity the contract
    log(`verifty   with npx hardhat verify --network ${networkName} ${svgNFT.address} `)

    log("Create NFT SVG start");

    var transationResponse = await svgNFT.add(4,5);
    // log(`Transation Response `, JSON.stringify(transationResponse));

    var reseipt = await transationResponse.wait(1);

    // log(`You've made an NFT `, JSON.stringify(reseipt));
    log(`You can View NFT Token here ${await svgNFT.getX()}`)

    
}
module.exports.tags=['test'];