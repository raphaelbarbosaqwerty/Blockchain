const Migrations = artifacts.require("ExampleToken");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
