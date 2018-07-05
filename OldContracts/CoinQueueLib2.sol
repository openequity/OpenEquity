pragma solidity ^0.4.15;

import "./OrderedStatisticTree.sol";
library CoinQueueLib2 {
  using OrderedStatisticTree for OrderedStatisticTree.Index;


	struct CoinQueue {

  		//bytes32 id;
  	  OrderedStatisticTree.Index customerValues;
   	  mapping(address=>uint) insertOrder;
	    mapping(address=>uint) customerBalance;
	    mapping(uint=>address) balanceTocustomer;
  //  mapping(address=>uint) positions;
      address firstInLine;
	    uint numbercustomers;

	}
	function createQueue()
    internal
    returns (CoinQueue)
  {
    return CoinQueue({
      customerValues: OrderedStatisticTree.Index(0),numbercustomers:0,firstInLine:0x3

          });
  }

	function insertcustomer(CoinQueue storage queue,address customer,uint value) returns (uint){
    	if(queue.customerBalance[customer]==0){
    	  queue.numbercustomers+=1;
 		 }
	    uint prevBalance=queue.customerBalance[customer];
	    queue.customerBalance[customer]+=value;
	  // queue.customerValues.remove(prevBalance);
      uint temp=queue.customerBalance[customer];
	    queue.customerValues.insert(temp);
	  // queue.positions[customer]=queue.customerValues.rank(value);
      uint Rank=queue.customerValues.rank(temp);
        if(Rank==queue.numbercustomers){
    	    queue.firstInLine=customer;
        }
        return Rank;
}
  function customerWithdraw(CoinQueue storage queue,address customer, uint value){
       uint prevBalance=queue.customerBalance[customer];
       queue.customerBalance[customer]-=value;
       queue.customerValues.remove(prevBalance);
       queue.customerValues.insert(queue.customerBalance[customer]);
       //queue.positions[customer]=queue.customerValues.rank(value);

  }
  function findcustomerPos(CoinQueue storage queue,address customer) returns(uint){
	uint balance=queue.customerBalance[customer];
  uint pos=queue.customerValues.rank(balance);
	  return pos;
	}
  function getFirstInLine(CoinQueue storage queue) returns(address){
    return queue.firstInLine;

  }
  function findbalance(CoinQueue storage queue,address customer) returns(uint){
     return queue.customerBalance[customer];

  }
  function findinserts(CoinQueue storage queue) returns(uint){
	   return queue.customerValues.numInserts();
  }
  function findvalueAtRank(CoinQueue storage queue,uint value) returns(uint){
	   return queue.customerValues.select_at(value);
	}
  function findheight(CoinQueue storage queue,uint value) returns(uint){
	   return queue.customerValues.node_height(value);
  }
  function findValueAtPercentile(CoinQueue storage queue,uint value) returns(uint){
  	return queue.customerValues.percentile(value);

  }
  function findNodeCount(CoinQueue storage queue, uint value) returns(uint){
    return queue.customerValues.node_count(value);
  }
}
