var Coin = artifacts.require('Coin');
var OrderStatisticTree=artifacts.require('OrderStatisticTree');

let TreeAddress;

contract('Coin', function(accounts) {

  OrderStatisticTree.deployed().then(instance=>{
    TreeAddress=instance.address
  })

  it('created a coin', async function() {
  var MyCoin=await Coin.deployed();
  var MyTree= await  OrderStatisticTree.deployed();
  await MyCoin.setTreeAddress(TreeAddress,{from:accounts[0]})
  await MyCoin.buyCoin({from:accounts[1],value:1000000000000})
    await MyCoin.buyCoin({from:accounts[2],value:1000000000})
  await MyCoin.buyCoin({from:accounts[3],value:100000000000})
  console.log(await MyTree.numInserts.call())















})



})
