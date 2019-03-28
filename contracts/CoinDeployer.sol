pragma solidity ^0.4.15;

import "./Coin.sol";



contract CoinDeployer{

mapping(uint=>address) public deployedAddresses;
mapping(address=>uint[] )public  CoinIDs;
uint CoinID;
address TreeDeploy;
address[] _PartnerArray;
uint[] _NumParams;
event CoinCreation(address C,address author);
constructor(address _tree){
TreeDeploy =_tree;
}
function deployCoin(
   address _authorAddress,
   

   string _tokenName,
   
   string _tokenSymbol,
   uint[] PartnerShares,
   uint[] _NumParams,
   address[] PartnerArray
  
   ){
   _PartnerArray=PartnerArray;
   _PartnerArray.push(TreeDeploy);
    Coin c= new Coin(_authorAddress,_tokenName,_tokenSymbol,PartnerShares,_NumParams,_PartnerArray);
    if(address(c)==address(0)) revert();

 if(!TreeDeploy.call(bytes4(sha3('deployTree(address,uint256,address)')),address(c),_NumParams[4],address(this))) revert();
  deployedAddresses[CoinID]=address(c);
  CoinID+=1;
  CoinIDs[_authorAddress].push(CoinID);
 emit CoinCreation(address(c),_authorAddress);
}

function getCoinLocation(uint coin) constant returns(address){
  return deployedAddresses[coin];
}
function myCoins(address a) constant returns(uint[]){
  return CoinIDs[a];
}






}
