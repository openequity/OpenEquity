var Coin = artifacts.require('Coin');
var OrderStatisticTree=artifacts.require('OrderStatisticTree');
var CoinPub=artifacts.require('./CoinPub.sol')
var CoinDeploy=artifacts.require('./CoinDeployer.sol')
var TreeDeploy=artifacts.require('./TreeDeployer.sol')
let TreeAddress;
let CoinDeployAddress
contract('Coin', function(accounts) {

  
  CoinDeploy.deployed().then(instance=>{
    CoinDeployAddress=instance.address
  })
  it('created a coin', async function() {
  var MyCoin=await Coin.deployed();
  var MyTree= await  TreeDeploy.deployed();
  var MyCoinD= await CoinDeploy.deployed()
  var CoinPb= await CoinPub.deployed()

  var PubAddress=CoinPb.address;

  console.log(PubAddress)
  await CoinPb.createCoinStruct(1,"MYCoin","BK","boardroom")
  await CoinPb.modifyCoinStruct(1,100,2,4,300,10,10)
  await CoinPb.publishCoin(1,18,100000000000000, 100000 )

  console.log(await MyCoinD.getCoinLocation(PubAddress))
  console.log(await MyTree.getTreeLocation(CoinDeployAddress))











})



})
