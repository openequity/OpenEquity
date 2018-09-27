pragma solidity ^0.4.15;

import "./CoinQueueLib2.sol";
import "./CoinDistLib.sol";
import "tokens/HumanStandardToken.sol";
import "./Math.sol";
contract Coin is HumanStandardToken {
  using CoinQueueLib2 for CoinQueueLib2.CoinQueue;
  using Math for *;
  address authorAddress;
  uint customershipStake;
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
  CoinQueueLib2.CoinQueue queue;

  function Coin
    (
     address _authorAddress,
     //bytes metadata,
     uint _customershipStake,
     uint _goal,
     //uint _toBeShipped,
     //uint _userCount,
     uint _eligibleCount,
     uint _initialAmount,
     string _tokenName,
     uint8 _decimalUnits,
     uint _startdate,
     uint _enddate,
     string _tokenSymbol,
     uint _weightCoefficient,
     uint _weightCoefficient2
     )
    HumanStandardToken(_initialAmount, _tokenName, _decimalUnits, _tokenSymbol){
    authorAddress = _authorAddress;
    customershipStake = _customershipStake;
    goal = _goal;
  //  userCount = _userCount;
    eligibleCount = _eligibleCount;
    setEligible=0;
    startdate=_startdate;
    enddate=_enddate;
    weightCoefficient=_weightCoefficient;
    weightCoefficient2=_weightCoefficient2;
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
    require(msg.sender==authorAddress);
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
    int weight=-1*( 0x10000000000000000*((int(weightCoefficient)*int(Time))+int(weightCoefficient2)*int(balance/goal) ));

    balances[msg.sender] += msg.value;
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
