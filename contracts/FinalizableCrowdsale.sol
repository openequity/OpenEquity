pragma solidity ^0.5.0;

import "./SafeMath.sol";
import "./TimedCrowdsale.sol";
import "./SpecifiedOwnable.sol";

/**
 * @title FinalizableCrowdsale
 * @dev Extension of TimedCrowdsale with a one-off finalization action, where one
 * can do extra work after finishing.
 */
contract FinalizableCrowdsale is TimedCrowdsale,SpecifiedOwnable {
    using SafeMath for uint256;

    bool private _finalized;
    mapping(address=>uint) public weiReceived;
    mapping(address=>bool) public tokenswithdrawn;
    event CrowdsaleFinalized();

    constructor (uint256 openingTime, uint256 closingTime,uint256 rate, address payable wallet, IERC20 token,address owner) 
    TimedCrowdsale(openingTime,closingTime,rate,wallet,token) SpecifiedOwnable(owner) public {
        _finalized = false;
    }

    /**
     * @return true if the crowdsale is finalized, false otherwise.
     */
    function finalized() public view returns (bool) {
        return _finalized;
    }

    /**
     * @dev Must be called after crowdsale ends, to do some extra finalization
     * work. Calls the contract's finalization function.
     */
    function finalize() public onlyOwner {
        require(!_finalized, "FinalizableCrowdsale: already finalized");
        require(hasClosed(), "FinalizableCrowdsale: not closed");

        _finalized = true;

        _finalization();
        emit CrowdsaleFinalized();
    }

    /**
     * @dev Can be overridden to add finalization logic. The overriding function
     * should call super._finalization() to ensure the chain of finalization is
     * executed entirely.
     */
    function _finalization() internal {
        // solhint-disable-previous-line no-empty-blocks
         _finalized = true;
    }

      function buyTokens(address beneficiary) onlyWhileOpen() public nonReentrant payable {
        uint256 weiAmount = msg.value;
       
      
        uint256 tokens = _getTokenAmount(weiAmount);
        preValidatePurchaseAmount(beneficiary,weiAmount);
        
        _weiRaised = _weiRaised.add(weiAmount);
        weiReceived[beneficiary]= weiReceived[beneficiary].add(weiAmount);
        //_processPurchase(beneficiary, tokens);
    
        
   
        emit TokensPurchased(msg.sender, beneficiary, weiAmount, tokens);

        //_updatePurchasingState(beneficiary, weiAmount);
   
        _forwardFunds();
       // _postValidatePurchase(beneficiary, weiAmount);
    }

    function setRate(uint r)  public onlyOwner{
        require(!_finalized, "FinalizableCrowdsale: already finalized");
        require(hasClosed(), "FinalizableCrowdsale: not closed");
         _rate=r;
    }

    function withdrawTokens() public nonReentrant {
         require(hasClosed(), "FinalizableCrowdsale: not closed");
         require(_finalized, "FinalizableCrowdsale: already finalized");
         require( tokenswithdrawn[msg.sender]==false,'tokens have been withdrawn already');
         uint256 tokens = _getTokenAmount(weiReceived[msg.sender]);
          tokenswithdrawn[msg.sender]=true;
         _processPurchase(msg.sender, tokens);
        
    }

     /**
     * @dev fallback function ***DO NOT OVERRIDE***
     * Note that other contracts will transfer funds with a base gas stipend
     * of 2300, which is not enough to call buyTokens. Consider calling
     * buyTokens directly when purchasing tokens from a contract.
     */
    function () external payable {
        buyTokens(msg.sender);
    }

}