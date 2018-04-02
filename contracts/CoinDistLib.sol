pragma solidity ^0.4.15;


import "./CoinPub.sol";

library CoinDistLib {

  event NewQualifyingcustomers ();          //Some customers become eligible after goal is met
  event CoinRequested(address customer);    //customer claims Coin
  event LogCoinShipped(address customer);   //Author sends shipping confirmation

  //Some customers become eligible to claim hard copy upon funding goal
  function prepShip(uint customers){
    //getFirstInLine(CoinQueue storage queue)
    //Coin.customerEligibilityAndBalance.eligibleForCoin = true;
    }
  //customers can claim hard copy after they become eligible
  function requestDelivery (){
    //require(Coin.customerEligibilityAndBalance.eligibleForCoin = false = true);
    //Coin.customerEligibilityAndBalance.eligibleForCoin = false;
    CoinRequested(msg.sender);
    }
  function markShipped (address customer){
    //How should I alert the customer?
    LogCoinShipped(customer);
    }

}
