pragma solidity ^0.4.15;

import "./Coin.sol";



contract CoinDeployer{

mapping(uint=>address) deployedAddresses;

address TreeDeploy;
//address TreeDeploy;
constructor(address _tree){
TreeDeploy =_tree;
}
function deployCoin(
   address _authorAddress,
    uint _customershipStake,
   uint _goal,
   uint _eligibleCount,
   uint _initialAmount,
   string _tokenName,
   uint8 _decimalUnits,
   uint _startdate,
   uint _enddate,
   string _tokenSymbol,
   uint _weightCoefficient,
   uint _weightCoefficient2,
   uint id

   ){
Coin c= new Coin(_authorAddress,_customershipStake,_goal,_eligibleCount,_initialAmount,_tokenName,_decimalUnits,_startdate,_enddate,_tokenSymbol,_weightCoefficient,_weightCoefficient2);


 if(!TreeDeploy.call(bytes4(sha3(("deployTree(address,uint256)"))),address(c),_eligibleCount)) revert();
deployedAddresses[id]=address(c);

}

function getCoinLocation(uint coin) constant returns(address){
  return deployedAddresses[coin];
}

function setTreeInCoin(address _coin) {
  require(msg.sender==TreeDeploy);
   Coin(_coin).setTreeAddress(_coin);
}




}
