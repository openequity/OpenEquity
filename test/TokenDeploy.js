


let CoinDeployer=artifacts.require('CoinCreator')
let OEToken=artifacts.require('OEToken')
let CrowdSale=artifacts.require('FinalizableCrowdsale')
let ContractInstance;
var time=(new Date().getTime())
time=Math.floor(time/1000);
contract('CoinCreator',function(accounts){
    CoinDeployer.deployed().then(instance=>{
       // console.log(instance)
        ContractInstance=instance
    })

it('creates a new token',async function(){
  let partners=[accounts[1],accounts[2],accounts[3],accounts[4],accounts[5]]  
  let shares=[10000,10000,10000,10000,100]
  await ContractInstance.deployToken('TestCoin',18,'TC',partners,shares,{from:accounts[1]} )
  let newAddress=await ContractInstance.deployedTokens(accounts[1],0)
  let newToken=await OEToken.at(newAddress)
  console.log(newToken)
  console.log(await newToken.partners(0))
  console.log( await newToken.balanceOf(accounts[1]))
  await newToken.getMyShare(0,{from:accounts[1]})
  assert.equal(await newToken.balanceOf(accounts[1]),10000,'user can get share')
 // (uint256 openingTime, uint256 closingTime,uint256 rate, address payable wallet, IERC20 token,address owner) 
  await ContractInstance.deployCrowdsale(time+100,time+1000,1,newAddress,accounts[1],{from:accounts[1]})
  let newFCAddress=await ContractInstance.deployedTokens(accounts[1],0)
  console.log(newFCAddress)



})














})