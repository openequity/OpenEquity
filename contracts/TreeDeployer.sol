pragma solidity ^0.4.15;

import "./OrderStatisticsTree.sol";



contract TreeDeployer{

mapping(address=>address) deployedAddresses;

function deployTree(address Owner,uint eligible){
OrderStatisticTree Tree= new OrderStatisticTree(Owner,eligible);

deployedAddresses[msg.sender]=address(Tree);
}
function getTreeLocation(address creator)  constant returns(address){
  return deployedAddresses[creator];
}





}
