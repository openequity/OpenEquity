pragma solidity ^0.4.15;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/CoinPub.sol";

contract TestCoinPub{

  function TestCoinIndex() public {
    CoinPub  Coin = CoinPub(DeployedAddresses.CoinPub());

	  uint expected=1;
	  uint expected1=3;

    Coin.publishCoin(1,'BK','MYCoin','boardroom');
    Coin.publishCoin(3,'BK1','MYCoin1','boardroom');
    uint ReaderStake=Coin.StructRet(1);
    uint ReaderStake2=Coin.StructRet(2);
    Assert.equal(ReaderStake, expected, "Readership stake should be 1");
    Assert.equal(ReaderStake2, expected1, "Readership stake should be 3");

  }






}
