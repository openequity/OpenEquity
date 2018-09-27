
//var GroveLib = artifacts.require('./GroveLib.sol');
//var OrderedStatisticTree=artifacts.require('./OrderedStatisticTree.sol')
//var CoinQueueLib = artifacts.require('./CoinQueueLib.sol');

var OrderStatisticTree = artifacts.require('./OrderStatisticTree.sol');
var CoinQueueLib = artifacts.require('./CoinQueueLib2.sol');
var Math= artifacts.require('./Math.sol')
var CoinPub = artifacts.require('./CoinPub.sol');
var Coin = artifacts.require('./Coin.sol');
var CoinDistLib = artifacts.require('./CoinDistLib.sol');
var Owned = artifacts.require('../contracts/Owned.sol');
var Stoppable = artifacts.require('../contracts/Stoppable.sol');
var TreeDeployer=artifacts.require('./TreeDeployer.sol')
var CoinDeploy=artifacts.require('./CoinDeployer.sol')

module.exports = function(deployer) {

//deployer.deploy(Owned);
//deployer.deploy(Stoppable);
//deployer.deploy(TreeDeployer);



  deployer.then(async () => {
  //await deployer.deploy(Owned);
  //await deployer.deploy(Stoppable);
  await deployer.deploy(TreeDeployer);
  let T=await TreeDeployer.deployed();
  T=T.address;
  //console.log(T)
  await deployer.deploy(Math);



  //deployer.link(OrderedStatisticTree, CoinQueueLib);
  await deployer.deploy(CoinQueueLib);

  await deployer.link(Math,Coin)
  await deployer.link(Math,CoinDeploy)
  await deployer.link(CoinQueueLib,CoinDeploy)
//  await deployer.link(CoinQueueLib, Coin);
  //await deployer.link(Math,CoinPub)
  let C=await deployer.deploy(CoinDeploy,T)
   C=C.address
   console.log(C)
  //await deployer.link(CoinQueueLib, CoinPub);

  await deployer.deploy(CoinPub,C);
  //await deployer.deploy(Coin,'0x627306090abaB3A6e1400e9345bC60c78a8BEf57',100,100,100,100,100,"TestCoin",10000,1,50,"TB",1,1);
  //let H=await Coin.deployed();
  //H=H.address
 // await deployer.deploy(CoinDistLib);
  //await deployer.deploy(OrderStatisticTree,H,100);
})

};
