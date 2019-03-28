var Migrations = artifacts.require("Migrations");

module.exports = function(deployer,network, account) {
  console.log(network)
  console.log(account)
  deployer.deploy(Migrations);
};
