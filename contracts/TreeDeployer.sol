pragma solidity ^0.4.15;

import "./OrderStatisticsTree.sol";



contract TreeDeployer{

mapping(address=>address) deployedAddresses;
//mapping(address=>address) coinAuthors;
function deployTree(address Owner,uint eligible,address CD){
OrderStatisticTree Tree= new OrderStatisticTree(Owner,eligible);

deployedAddresses[Owner]=address(Tree);
address sender=msg.sender;
 if(!Owner.call(bytes4(sha3('setTreeAddress(address)')),address(Tree))) revert();
}
function getTreeLocation(address creator)  constant returns(address){
  return deployedAddresses[creator];
}





}
