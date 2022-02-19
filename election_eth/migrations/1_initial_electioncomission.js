const ElectionComission = artifacts.require("ElectionComission");

module.exports = function (deployer) {
  deployer.deploy(ElectionComission);
};
