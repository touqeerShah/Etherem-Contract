module.exports = async ({
    getNamedAccounts,
    deployments,
    getChainId
}) => {

    const {
        deploy,
        log
    } = deployments;
    const {
        deployer
    } = await getNamedAccounts();
    const chainId = await getChainId();

    log("--------------------------------");
    const contractStorage = await deploy("ContractStorage", {
        from: deployer,
        log: true
    })
    log(`ContractStorage contract is deployed on local network to ${contractStorage.address} ${chainId}`);




}

module.exports.tags = ['all','rsvg', 'svg','storage']