
//var GroveLib = artifacts.require('./GroveLib.sol');
//var OrderedStatisticTree=artifacts.require('./OrderedStatisticTree.sol')
//var CoinQueueLib = artifacts.require('./CoinQueueLib.sol');

var OrderStatisticTree = artifacts.require('./OrderStatisticTree.sol');
var CoinQueueLib = artifacts.require('./CoinQueueLib2.sol');

var CoinPub = artifacts.require('./CoinPub.sol');
var Coin = artifacts.require('./Coin.sol');
var CoinDistLib = artifacts.require('./CoinDistLib.sol');
var Owned = artifacts.require('../contracts/Owned.sol');
var Stoppable = artifacts.require('../contracts/Stoppable.sol');

module.exports = function(deployer) {
  deployer.then(async () => {
  await deployer.deploy(Owned);
  await deployer.deploy(Stoppable);
  await deployer.deploy(TreeDeployer);



  //deployer.link(OrderedStatisticTree, CoinQueueLib);
  await deployer.deploy(CoinQueueLib);
  await deployer.link(CoinQueueLib, Coin);
  await deployer.link(CoinQueueLib, CoinPub);

  await deployer.deploy(CoinPub);
  await deployer.deploy(Coin,'0x627306090abaB3A6e1400e9345bC60c78a8BEf57',100,100,100,100,100,"TestCoin",10000,1,50,"TB");
  let H=await Coin.deployed();
  H=H.address
  await deployer.deploy(CoinDistLib);
  await deployer.deploy(OrderStatisticTree,H);
})
};
