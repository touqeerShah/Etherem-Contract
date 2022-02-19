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
    if (chainId == 31337) {
        log("Network is detected to be mock");
        const linkToken = await deploy("LinkToken", {
            from: deployer,
            log: true
        })
        log(`linkToken contract is deployed on local network to ${linkToken.address} ${chainId}`);
        const vrfCoordinatorMock = await deploy("VRFCoordinatorMock", {
            from: deployer,
            log: true,
            args:[linkToken.address]
        })
        log(`VRFCoordinatorMock contract is deployed on local network to ${vrfCoordinatorMock.address} ${chainId}`);
        
    }


}
module.exports.tags = ['all','rsvg', 'svg', 'link']


