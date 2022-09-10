const sigVerify = artifacts.require("sigVerify");

module.exports = function (deployer) {
  deployer.deploy(sigVerify);
};
