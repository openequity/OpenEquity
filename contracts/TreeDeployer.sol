pragma solidity ^0.4.15;

import "./OrderStatisticTree.sol"



contract TreeDeployer(){

mapping(address=>address) deployedAddresses;

function deployTree(address Owner){
OrderStatisticTree Tree= new OrderStatisticTree(Owner);
deployedAddresses[msg.sender]=Tree.this;
}

function getTreeLocation(address creator) returns(address){
  return deployedAddresses[creator];
}





}
