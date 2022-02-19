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

    const TKSVGToken = await deploy("SVGNTF",{
        from: deployer,
        log: true
    })
    log(`Your contract is deployed on local network to ${TKSVGToken.address} ${chainId}`);
    let svg = fs.readFileSync("./img/dog.svg",{encoding:"utf-8"});
    const svgContract = await ethers.getContractFactory("SVGNTF")
    const accounts = await hre.ethers.getSigners(); // this is hardhat object which will return all the accounts of local networks
    const signer= accounts[0];
    log(`Account Address`,JSON.stringify(signer))
    const svgNFT = new ethers.Contract(TKSVGToken.address,svgContract.interface,signer);

    const networkName= networkConfig[chainId]['name']; // this will help as when we deployed contract on real network it help as to verity the contract
    log(`verifty   with npx hardhat verify --network ${networkName} ${svgNFT.address} `)

    log("Create NFT SVG start");

    var transationResponse = await svgNFT.createNFT(svg);
    // log(`Transation Response `, JSON.stringify(transationResponse));

    var reseipt = await transationResponse.wait(1);

    // log(`You've made an NFT `, JSON.stringify(reseipt));
    log(`You can View NFT Token here ${await svgNFT.tokenURI(1)}`)

    
}
module.exports.tags=['svg'];