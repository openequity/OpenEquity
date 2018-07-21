library CoinQueueLib2 {
  //using OrderedStatisticTree for OrderedStatisticTree.Index;

  struct CoinQueue {

  		//bytes32 id;

   	  mapping(address=>uint) insertOrder;
	    mapping(address=>uint) customerBalance;
	    mapping(uint=>address) balanceTocustomer;
  //  mapping(address=>uint) positions;
      uint greatestCustomerPurchase;
      address firstInLine;
	    uint numbercustomers;

	}
	function createQueue()
    internal
    returns (CoinQueue)
  {
    return CoinQueue({
      numbercustomers:0,firstInLine:0x3,greatestCustomerPurchase:0

          });
  }




	function insertcustomer(CoinQueue storage queue,address customer,uint value,address StatisticsTree) returns (bool){
    	if(queue.customerBalance[customer]==0){
    	  queue.numbercustomers+=1;
 		 }
	    uint prevBalance=queue.customerBalance[customer];
	    queue.customerBalance[customer]+=value;
	  // customerValues.remove(prevBalance);
      CallRemove(StatisticsTree,prevBalance);
      uint temp=queue.customerBalance[customer];
	    CallInsert(StatisticsTree,temp);
	  // positions[customer]=customerValues.rank(value);

        return true;
}
  function customerWithdraw(CoinQueue storage queue,address customer, uint value,address StatisticsTree) returns(bool){
       uint prevBalance=queue.customerBalance[customer];
       queue.customerBalance[customer]-=value;
       uint temp=queue.customerBalance[customer];
       CallRemove(StatisticsTree,prevBalance);
       CallInsert(StatisticsTree,temp);
       //positions[customer]=customerValues.rank(value);
       return true;
		 }
		 function CallInsert(address c,uint value){
			 if(!c.call(bytes4(keccak256("insert(uint256)")),value )) revert();
		 }
		 function CallRemove(address c,uint value){
	 		if(!c.call(bytes4(keccak256("remove(uint256)")),value )) revert();
	 	}

}
