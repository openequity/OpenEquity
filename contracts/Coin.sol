pragma solidity ^0.4.15;

import "./CoinQueueLib2.sol";
import "./CoinDistLib.sol";
import "tokens/HumanStandardToken.sol";
import "./Math.sol";
contract Coin is HumanStandardToken {
  using CoinQueueLib2 for CoinQueueLib2.CoinQueue;
  using Math for *;
  address authorAddress;
  
  uint balance;
  uint goal;
  uint setEligible;
  uint userCount;
  uint eligibleCount;
  uint public startdate;
  uint public enddate;
  uint gasSaved;
  address public StatisticsTree;
  uint weightCoefficient;
  uint weightCoefficient2;
  address Deployer;
  uint price;
  CoinQueueLib2.CoinQueue queue;
  address[] partners;
  uint[] partnerShares;
      //uint goal	numParams[0];
      //uint eligibleCount numParams[1];
	    //uint startdate numParams[2];
	    //uint enddate numParams[3];
      //uint   weightCoefficient numParams[4];
      //uint   weightCoefficient2 numParams[5];
      // uint price numParams[6];
      // decimal places numParams[7]
      // PartnerShares[0] founder coin, PartnerShares[1] coins for sale
  function Coin
    (
      address _authorAddress,
   

      string _tokenName,
   
      string _tokenSymbol,
      uint[] _PartnerShares,
      uint[] numParams,
      address[] _PartnerArray
     )
    HumanStandardToken(_PartnerShares[0], _tokenName, uint8(numParams[7]), _tokenSymbol,_authorAddress){
    authorAddress = _authorAddress;
   
    goal = numParams[0];
    balances[address(this)]=_PartnerShares[1];
    
    setEligible=0;
    eligibleCount = numParams[1];
    startdate=numParams[2];
    enddate=numParams[3];
    weightCoefficient=numParams[4];
    weightCoefficient2=numParams[5];
    price=numParams[6];
    partners=_PartnerArray;
    partnerShares= _PartnerShares;

    
    Deployer=msg.sender;
   
  }

  enum customerStatus { Waiting, Eligible, Requested, Shipped, Confirmed }

  struct customer {
    uint id;
    uint points;
    bytes customerUsername;      //customer's username
    customerStatus status;

  }

  event BoughtCoin(address customer, uint amountPaid);
  event GoalMet(bool success);
  event NewQualifyingcustomers ();          //Some customers become eligible after goal is met
  event CoinRequested(address customer);    //customer claims Coin
  event LogCoinShipped(address customer);   //Author sends shipping confirmation
  event LogCoinConfirmed(address customer);   //Author sends shipping confirmation
  mapping(uint=>bool) validPoints;
  mapping (address => customer) customers;
  mapping(uint=>uint) weeklysales;
//  mapping(address=>uint) balances;
  modifier goalMet {
    require (goalReached()&&(now>enddate));
    _;
  }
  modifier TimeValid {
    require ((startdate>now)&&(enddate<now));
    _;
  }
 modifier isAuthor{
   require(msg.sender==authorAddress);
   _;
 }
  function goalReached()
   constant  returns (bool goalMet)
  {
    return balance >= goal;
  }

  function goalFailed()
    returns (bool goalFailed)
  {
    return ((balance<goal)&&(now>enddate));
  }
  function setTreeAddress(address a) {
    require(msg.sender==partners[partners.length-1]);
    StatisticsTree=a;
  }
  function buyCoin()
    public
    payable
    returns(bool success){

    // customer buys coins the first time
    if (balances[msg.sender] == 0) {
      // Add customer
      customers[msg.sender] = customer({ id: userCount, customerUsername: 'Anonymous', status: customerStatus.Waiting,points:0 });
      userCount++;

      // Add the customer to the queue in the last position
    }
    uint Time=((now-startdate)*10000000000)/(enddate-startdate);
    int weight=(-1*( 0x28f5c28f5c28f60*((int(weightCoefficient)*int(Time))+int(weightCoefficient2)*int(balance*10/goal) )));
    balances[address(this)]-=msg.value/price;
    balances[msg.sender] += msg.value/price;
    uint _points=((weight.exp()*(msg.value))/0x10000000000000000);
    customers[msg.sender].points+=_points;
    if(balance<goal){
      if(!queue.insertcustomer( msg.sender,_points,StatisticsTree)) revert();
    }
    if (goalReached()) {
      if(!StatisticsTree.call(bytes4(keccak256("SetGoalReached()")))) revert();
      GoalMet(true);
    }

  //  queue.addToQueue(int(msg.value), msg.sender);

    balance += msg.value;
    weekSaleSum( msg.value);
    return true;
  }

  function getPoints(address a) constant returns(uint){
    return customers[a].points;
  }

  function distributePartnerShare(){
    for(uint i=2;i<partners.length;i++){
      balances[partners[i]]=partnerShares[i];
    }
  }

  function weekSaleSum(uint value){
  //  uint currentday=((now-start)/86400)%7;
    uint currentweek=((now-startdate)/86400)/7;
    weeklysales[currentweek]+=value;
  }
  function ETA(uint week)returns (uint){
    uint temp= weeklysales[week];
    temp=temp/7;
    uint ETA=goal/temp;
    return(ETA);
  }
  // Anyone can call this
  // Idealy the author should as soon as the goal is met
  function setFirstEligible()
    goalMet
    returns (bool success)
  {

    setEligible++;
    //address first = queue.getFirstInLine();
    //customers[first].status = customerStatus.Eligible;
  //  queue.remove(first, int(balances[first]));
    return true;
  }
  function addEligible(uint value) goalMet{
  require(msg.sender==StatisticsTree);
  require(setFirstEligible());
  validPoints[value]=true;

  }
  //((Author)) withdraws the capital they earned through coin sales
  function withdrawCapital()
    goalMet
    isAuthor {
    authorAddress.transfer(balance);
  }
  /*function withdrawInvestment(){
    uint temp=balances[msg.sender];
    balances[msg.sender]=0;
    queue.customerWithdraw(msg.sender,temp,StatisticsTree);
    msg.sender.transfer(temp);

  }
  */
  function CalculateWeight(uint w, uint w1) constant returns(int,uint,uint){
  uint Time=w*((now-startdate)*10000000000)/(enddate-startdate);
  int weight=-1*(  0x28f5c28f5c28f60*((int(w)*int(Time))+int(w1)*int((balance*10/goal)) ));

  uint _points=((weight.exp()*(10**18))/0x10000000000000000);
  return (weight,Time,_points);
  }
  function claimCoins()
     goalMet
  {
    uint temp=balances[msg.sender];
    balances[msg.sender]=0;
    if(!queue.customerWithdraw(msg.sender,temp,StatisticsTree)) revert();
    msg.sender.transfer((temp/balance));
  }
  //customers can claim hard copy after they become eligible
  function requestDelivery (address customerAddress) returns (bool success) {
    require(customers[customerAddress].status == customerStatus.Eligible);
    customers[customerAddress].status = customerStatus.Requested;
    CoinRequested(msg.sender);
    return true;
  }

  function markShipped (address customer) returns (bool success) {
    require(customers[customer].status == customerStatus.Requested);
    customers[customer].status = customerStatus.Shipped;
    LogCoinShipped(customer);
    return true;
  }

  function confirmDelivery (address customer) returns (bool success) {
    require(customers[customer].status == customerStatus.Shipped);
    customers[customer].status = customerStatus.Confirmed;
    LogCoinConfirmed(customer);
    return true;
  }

}
