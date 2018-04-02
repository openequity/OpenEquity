pragma solidity ^0.4.15;

import "truffle/Assert.sol";
import "../contracts/CoinQueueLib.sol";

contract TestCoinQueueLib{
  using CoinQueueLib for CoinQueueLib.CoinQueue;

  CoinQueueLib.CoinQueue queue;

  function beforeAll(){
    //queue = CoinQueueLib.createNew();
  }

  function test0_AddFirstcustomer(){
    address customerAddress = 0x3;
    int value = 2;

    queue.addToQueue(value, customerAddress);
    Assert.equal(queue.getFirstInLine(), customerAddress, "customer not added");
  }

  /* function test1_testAddAnothercustomerHigherValue(){ */
  /*   address customerAddress = 0x5; */
  /*   int value = 3; */
  /*   queue.addToQueue(value, customerAddress); */
  /*   Assert.equal(queue.getFirstInLine(), customerAddress, "customer not placed at front of line"); */

  /* } */
  /* function test2_testAddAnothercustomerLowerValue(){ */
  /*   address currentFirstInLine = queue.getFirstInLine(); */
  /*   address customerAddress = 0x6; */
  /*   int value = 1; */
  /*   queue.addToQueue(value, customerAddress); */
  /*   Assert.equal(queue.getLinePosition(0), currentFirstInLine, "customer not added correctly"); */
  /* } */

  /* function test3_testAddAnothercustomerSameValue(){ */
  /*   address customerAddress = 0x7; */
  /*   int value = 3; */
  /*   queue.addToQueue(value, customerAddress); */
  /*   Assert.equal(queue.getLinePosition(1), customerAddress, "customer not added correctly"); */
  /*   } */

  function test4_testEnumerateLine(){
    // queue.getLine or getcustomerAtPositionInLine or ???
    //
  }

  //test function to make sure line enumeration works as expected


}
