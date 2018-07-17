pragma solidity ^0.4.15;

import "./CoinQueueLib2.sol";
import "./CoinDistLib.sol";
import "tokens/HumanStandardToken.sol";

contract Coin is HumanStandardToken {
  using CoinQueueLib2 for CoinQueueLib2.CoinQueue;
  address authorAddress;
  uint customershipStake;
  uint balance;
  uint goal;
  uint toBeShipped;
  uint userCount;
  uint eligibleCount;
  uint startdate;
  uint enddate;
  uint gasSaved;
  CoinQueueLib2.CoinQueue queue;

  function Coin
    (
     address _authorAddress,
     //bytes metadata,
     uint _customershipStake,
     uint _goal,
     uint _toBeShipped,
     //uint _userCount,
     uint _eligibleCount,
     uint _initialAmount,
     string _tokenName,
     uint8 _decimalUnits,
     uint _startdate,
     uint _enddate,
     string _tokenSymbol)
    HumanStandardToken(_initialAmount, _tokenName, _decimalUnits, _tokenSymbol){
    authorAddress = _authorAddress;
    customershipStake = _customershipStake;
    goal = _goal;
  //  userCount = _userCount;
    eligibleCount = _eligibleCount;
    toBeShipped = _toBeShipped;
    startdate=_startdate;
    enddate=_enddate;
  }

  enum customerStatus { Waiting, Eligible, Requested, Shipped, Confirmed }

  struct customer {
    uint id;
    bytes customerUsername;      //customer's username
    customerStatus status;
  }

  event BoughtCoin(address customer, uint amountPaid);
  event GoalMet(bool success);
  event NewQualifyingcustomers ();          //Some customers become eligible after goal is met
  event CoinRequested(address customer);    //customer claims Coin
  event LogCoinShipped(address customer);   //Author sends shipping confirmation
  event LogCoinConfirmed(address customer);   //Author sends shipping confirmation

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

  function goalReached()
    returns (bool goalMet)
  {
    return balance >= goal;
  }

  function goalFailed()
    returns (bool goalFailed)
  {
    return ((balance<goal)&&(now>enddate));
  }

  function buyCoin()
    public
    payable
    returns(bool success){

    // customer buys coins the first time
    if (balances[msg.sender] == 0) {
      // Add customer
      customers[msg.sender] = customer({ id: userCount, customerUsername: 'Anonymous', status: customerStatus.Waiting });
      userCount++;

      // Add the customer to the queue in the last position
    }

    balances[msg.sender] += msg.value;
    queue.insertcustomer( msg.sender,uint(balances[msg.sender]));

    if (goalReached()) {
      GoalMet(true);
    }

  

    balance += msg.value;
    weekSaleSum( msg.value);
    return true;
  }

  function getFirstInLine()

  {

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
    require(eligibleCount <= toBeShipped);
    eligibleCount++;
    //address first = queue.getFirstInLine();
    //customers[first].status = customerStatus.Eligible;
  //  queue.remove(first, int(balances[first]));
    return true;
  }

  //((Author)) withdraws the capital they earned through coin sales
  function withdrawCapital()
    goalMet
    /*isAuthor()*/{
    authorAddress.transfer(balance);
  }
  function withdrawInvestment(){
    uint temp=balances[msg.sender];
    balances[msg.sender]=0;
    msg.sender.transfer(temp);

  }
  function claimCoins()
     goalMet
  {
    uint temp=balances[msg.sender];
    balances[msg.sender]=0;
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
