
//var GroveLib = artifacts.require('./GroveLib.sol');
var OrderedStatisticTree=artifacts.require('./OrderedStatisticTree.sol')
//var CoinQueueLib = artifacts.require('./CoinQueueLib.sol');

var OrderedStatisticTree = artifacts.require('./OrderedStatisticTree.sol');
var CoinQueueLib = artifacts.require('./CoinQueueLib2.sol');

var CoinPub = artifacts.require('./CoinPub.sol');
var Coin = artifacts.require('./Coin.sol');
var CoinDistLib = artifacts.require('./CoinDistLib.sol');
var Owned = artifacts.require('../contracts/Owned.sol');
var Stoppable = artifacts.require('../contracts/Stoppable.sol');

module.exports = function(deployer) {
  deployer.deploy(Owned);
  deployer.deploy(Stoppable);
  deployer.deploy(OrderedStatisticTree);



  deployer.link(OrderedStatisticTree, CoinQueueLib);
  deployer.deploy(CoinQueueLib);
  deployer.link(CoinQueueLib, Coin);
  deployer.link(CoinQueueLib, CoinPub);

  deployer.deploy(CoinPub);
  deployer.deploy(Coin,'0x627306090abaB3A6e1400e9345bC60c78a8BEf57',100,100,100,100,100,"TestCoin",10000,1,50,"TB");
  deployer.deploy(CoinDistLib);

};
