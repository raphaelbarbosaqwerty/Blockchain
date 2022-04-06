const Migrations = artifacts.require("HelloWorld"); // Name of the contract

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
