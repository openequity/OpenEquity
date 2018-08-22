pragma solidity ^0.4.15;

import "./Coin.sol";



contract CoinDeployer{

mapping(address=>address) deployedAddresses;


function deployCoin(
   address _authorAddress,
   //bytes metadata,
   uint _customershipStake,
   uint _goal,
   uint _toBeShipped,
   //uint _userCount,
   uint _eligibleCount,
   uint _initialAmount,
   string _tokenName,
   uint8 _decimalUnits,
   uint _startdate,
   uint _enddate,
   string _tokenSymbol,
   uint _weightCoefficient,
   uint _weightCoefficient2,
   address TreeDeploy

   ){
Coin C= new Coin(_authorAddress,_customershipStake,_goal,_toBeShipped,_eligibleCount,_initialAmount,_tokenName,_decimalUnits,_startdate,_enddate,_tokenSymbol,_weightCoefficient,_weightCoefficient2);
address  T=address(C);
 TreeDeploy.call(bytes4(sha3(("deployTree(address,uint256)"))),T,_eligibleCount);
deployedAddresses[msg.sender]=address(C);
}

function getCoinLocation(address creator) constant returns(address){
  return deployedAddresses[creator];
}





}
