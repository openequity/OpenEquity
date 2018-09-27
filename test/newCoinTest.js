var Coin = artifacts.require('Coin');
var OrderStatisticTree=artifacts.require('OrderStatisticTree');
var CoinPub=artifacts.require('./CoinPub.sol')
var CoinDeploy=artifacts.require('./CoinDeployer.sol')
var TreeDeploy=artifacts.require('./TreeDeployer.sol')
let TreeAddress;
let CoinDeployAddress
var Web3=require('web3')
var web3=new Web3()
var time=(new Date().getTime())
time=time/1000;
console.log(time + "tim")
var endTime=time+10
function sleep(ms){
    return new Promise(resolve=>{
        setTimeout(resolve,ms)
    })
}

contract('Coin', function(accounts) {


  CoinDeploy.deployed().then(instance=>{
    CoinDeployAddress=instance.address
  })
  it('created a coin', async function() {
  console.log(Coin)
  var MyTree= await  TreeDeploy.deployed();

  var MyCoinD= await CoinDeploy.deployed()
    DeployAddress=MyCoinD.address
  var CoinPb= await CoinPub.deployed()

  var PubAddress=CoinPb.address;

  console.log(PubAddress)
  console.log(DeployAddress)
  console.log("started")
  await CoinPb.createCoinStruct(1,"MYCoin","BK","boardroom",{from:accounts[0]})
  console.log("created")
  //modifyCoinStruct(uint _CoinID,uint _goal,uint _startdate,uint _enddate,uint _eligibleCount,uint _weight, uint _weight2)
  await CoinPb.modifyCoinStruct(1,100,time,endTime,300,1,1,{from:accounts[0]})
    console.log("created")
  await CoinPb.publishCoin(1,18,100000000000000,{from:accounts[0]})

  var coinaddress=await MyCoinD.getCoinLocation(1)
  const CoinInstance=(Coin.at(coinaddress))
  var treeAddress= await MyTree.getTreeLocation(coinaddress)
  const TreeInstance=OrderStatisticTree.at(treeAddress);
  //console.log(TreeInstance)
  await CoinInstance.setTreeAddress(treeAddress,{from:accounts[0]})
 await CoinInstance.buyCoin({from:accounts[1],value:100000000000})
 console.log(await TreeInstance.select_at(0))
 console.log(await CoinInstance.getPoints(accounts[1]))
  //console.log(await MyTree.getTreeLocation(DeployAddress))









})



})
