const fs = require("fs");
const {
    exec
} = require("child_process");
let {
    networkConfig
} = require("../helper.config.js")
module.exports = async ({
    getNamedAccounts,
    deployments,
    getChainId
}) => {

    const {
        deploy,
        log,
        get
    } = deployments;
    const {
        deployer
    } = await getNamedAccounts();
    const chainId = await getChainId();

    log("--------------------------------");
    log("Deployer Address", deployer);
    // for local deployment as we used chain link api for random number so we need link 
    // we will deploy that link contract local and used it but when we are in real or test net then we used already deployed net
    let linkTokenAddress, vrfCoordinatorMockAddress, storageContractAddress;
    // this is storage class it always required to deploy with we deploy nft

    let storageContract = await get("ContractStorage");
    storageContractAddress = storageContract.address;
    if (chainId == 31337) {
        let linkToken = await get("LinkToken");
        let vrfCoordinatorMock = await get("VRFCoordinatorMock");
        linkTokenAddress = linkToken.address;
        vrfCoordinatorMockAddress = vrfCoordinatorMock.address;
        log("vrfCoordinatorMockAddress Address", vrfCoordinatorMockAddress,"  linkTokenAddress ",linkTokenAddress);

    } else {
        linkTokenAddress = networkConfig[chainId]['LINKAddress'];;
        vrfCoordinatorMockAddress = networkConfig[chainId]['VRFCoordinatorAddress'];
    }
    var keyHash = networkConfig[chainId]['KeyHash'];
    var fee = networkConfig[chainId]['Fee']
    let args = [ vrfCoordinatorMockAddress, linkTokenAddress, keyHash, fee,storageContractAddress];
    log("args ==>", args);

    const randomSVGNTF = await deploy("test", {
        from: deployer,
        args: [vrfCoordinatorMockAddress.trim(),linkTokenAddress.trim(),storageContractAddress],
        log: true
    })
    log(`Your contract is deployed on local network to ${randomSVGNTF.address} ${chainId}`);
    // fund with link coin to used orical 

    log(`Get Fund for local link Contract and transfer contract`)

    const linkTokenContract = await ethers.getContractFactory("test")
    const accounts = await hre.ethers.getSigners(); // this is hardhat object which will return all the accounts of local networks
    const signer = accounts[0];
    let linkToken = new ethers.Contract(randomSVGNTF.address, linkTokenContract.interface, signer);
    let fund_tx = await linkToken.add();
    await fund_tx.wait(1);
    log(`Fund Transfer to contract ${randomSVGNTF.address}`)



    // ////////////////////////////////////////
    // log(`Now Create New NFT Token`)

    // const randomSvgContract = await ethers.getContractFactory("RandomSVGNTF")
    // const randomSvgNFT = new ethers.Contract(randomSVGNTF.address, randomSvgContract.interface, signer);

    // const networkName = networkConfig[chainId]['name']; // this will help as when we deployed contract on real network it help as to verity the contract
    // log(`verifty   with npx hardhat verify --network ${networkName} ${randomSvgNFT.address} `)

    // log("Create NFT SVG start");

    // var transationResponse = await randomSvgNFT.createNFT({
    //     gasLimit: 300000
    // });
    // // log(`Transation Response `, JSON.stringify(transationResponse));

    // var reseipt = await transationResponse.wait(1);

    // log(`You've made an NFT `, JSON.stringify(reseipt.events));
    // // log(`You can View NFT Token here ${await randomSvgNFT.tokenURI(1)}`)
    // let tokenId = receipt.events[3].topics[2]
    // log(`You've made your NFT! This is number ${tokenId}`)
    // log("Let's wait for the Chainlink VRF node to respond...")
    // if (chainId != 31337) {
    //     await new Promise(r => setTimeout(r, 180000))
    //     log(`Now let's finsih the mint...`)
    //     tx = await randomSVG.finishMint(tokenId, {
    //         gasLimit: 2000000
    //     })
    //     await tx.wait(1)
    //     log(`You can view the tokenURI here ${await randomSVG.tokenURI(0)}`)
    // } else {
    //     const VRFCoordinatorMock = await deployments.get('VRFCoordinatorMock')
    //     vrfCoordinator = await ethers.getContractAt('VRFCoordinatorMock', VRFCoordinatorMock.address, signer)
    //     let transactionResponse = await vrfCoordinator.callBackWithRandomness(receipt.logs[3].topics[1], 77777, randomSVG.address)
    //     await transactionResponse.wait(1)
    //     log(`Now let's finsih the mint...`)
    //     tx = await randomSVG.finishMint(tokenId, {
    //         gasLimit: 2000000
    //     })
    //     await tx.wait(1)
    //     log(`You can view the tokenURI here ${await randomSVG.tokenURI(1)}`)
    // }

}

module.exports.tags = ['rsvg'];