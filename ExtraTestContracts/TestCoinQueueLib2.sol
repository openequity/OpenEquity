pragma solidity ^0.4.15;

import "truffle/Assert.sol";
import "../contracts/CoinQueueLib2.sol";

contract TestCoinQueueLib2{
  using CoinQueueLib2 for CoinQueueLib2.CoinQueue;

  CoinQueueLib2.CoinQueue queue;
  CoinQueueLib2.CoinQueue queue1;
  CoinQueueLib2.CoinQueue queue2;
  function beforeAll(){
  //  queue = CoinQueueLib.createNew();
  }

  function test0_insertcustomer(){
	   address customerAddress = 0x3;
	   address customerAddress1 = 0x4;
	   address customerAddress2= 0x5;
     address customerAddress3 = 0x6;
   	 uint value = 2;
	   uint value1=5;
	   uint value2=9;
     uint value3=12;
	   uint order=1;
   	 queue.insertcustomer( customerAddress,value);
	   queue.insertcustomer( customerAddress1,value1);
	   queue.insertcustomer( customerAddress2,value2);
     queue.insertcustomer( customerAddress3,value3);
	   Assert.equal(queue.findcustomerPos(customerAddress), queue.findcustomerPos(customerAddress1), "Rank failiing");
  }
   function test0_insertcustomer2(){
	    address customerAddress = 0x3;
	    address customerAddress1 = 0x4;
    	uint value = 2;
      uint value1=5;
    	uint order=1;
      queue1.insertcustomer( customerAddress,value);
	    queue1.insertcustomer( customerAddress1,value1);
	    address customerAddress2= 0x5;
      uint value2=9;
	    queue1.insertcustomer( customerAddress2,value2);
	    Assert.equal(queue.findvalueAtRank(2), 1, "customer not added");
  }
  function test0_insertcustomer3(){
	  address customerAddress = 0x3;
	  address customerAddress1 = 0x4;
	  address customerAddress2= 0x5;
    address customerAddress3 = 0x6;
   	uint value = 2;
	  uint value1=5;
	  uint value2=9;
    uint value3=12;

    queue2.insertcustomer( customerAddress3,value);
	  queue2.insertcustomer( customerAddress2,value1);
	  queue2.insertcustomer( customerAddress1,value2);
    queue2.insertcustomer( customerAddress,value3);
	  uint x=queue2.findNodeCount(value);
	//uint y=queue2.findNodeCount(value1);
	  Assert.equal(x, 1, "Rank failiing");
  }
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
