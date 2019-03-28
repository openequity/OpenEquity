var Coin = artifacts.require('Coin');
var OrderStatisticTree=artifacts.require('OrderStatisticTree');
//var CoinPub=artifacts.require('./CoinPub.sol')
var CoinDeploy=artifacts.require('./CoinDeployer.sol')
var TreeDeploy=artifacts.require('./TreeDeployer.sol')
let TreeAddress;
let CoinDeployAddress
var Web3=require('web3')
var web3=new Web3()
//console.log(web3)
var time=(new Date().getTime())
time=time/1000;
console.log(time + "tim")
var endTime=time+10
function sleep(ms){
    return new Promise(resolve=>{
        setTimeout(resolve,ms)
    })
}
 //uint goal	numParams[0];
      //uint eligibleCount numParams[1];
	    //uint startdate numParams[2];
	    //uint enddate numParams[3];
      //uint   weightCoefficient numParams[4];
      //uint   weightCoefficient2 numParams[5];
       // uint price numParams[6];
      // decimal places numParams[7]
contract('Coin', function(accounts) {


  CoinDeploy.deployed().then(instance=>{
    CoinDeployAddress=instance.address
  })
  it('created a coin', async function() {
  var PartnerArray=[accounts[1],accounts[2],accounts[3]]
  console.log(PartnerArray)
  var PartnerFunds=[1000000,100000,1000,10000,500]
  console.log(PartnerFunds)
  var decimals=18;
  var Start=time
  var End=endTime
  var w1=0
  var w2=1
  var goal=10000*10**18
  var price=10000000
  var eligibleCount=10000
  var N=[goal,eligibleCount,10000000,100000000,w1,w2,price,decimals]
  console.log(N)
  var name="Open Equity"
  var Symbol="OE"

  var MyTree= await  TreeDeploy.deployed();

  var MyCoinD= await CoinDeploy.deployed()
  //console.log(MyCoinD)
  await MyCoinD.deployCoin(accounts[0],name,Symbol,[1000000,100000,1000,10000,500],N,PartnerArray)


    DeployAddress=MyCoinD.address
  //var CoinPb= await CoinPub.deployed()

  //var PubAddress=CoinPb.address;



  var coinaddress=await MyCoinD.getCoinLocation(0)
  //console.log( coinaddress)
  const CoinInstance=(Coin.at(coinaddress))
  console.log(CoinInstance.contract)
  var treeAddress= await MyTree.getTreeLocation(coinaddress)
  console.log(treeAddress)
  const TreeInstance=OrderStatisticTree.at(treeAddress);
  //console.log(TreeInstance)
 
 await CoinInstance.buyCoin({from:accounts[1],value:10000000000000000000})
 console.log(await TreeInstance.select_at(0))
 console.log(await CoinInstance.getPoints(accounts[1]))
 console.log(await CoinInstance.balanceOf(accounts[1]))
 console.log(await CoinInstance.goalReached())
  //console.log(await MyTree.getTreeLocation(DeployAddress))









})



})