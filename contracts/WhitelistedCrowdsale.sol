pragma solidity ^0.5.0;
import "./Crowdsale.sol";
import "./WhitelistedRole.sol";
//import "./IncreasingPriceCrowdsale.sol";


/**
 * @title WhitelistCrowdsale
 * @dev Crowdsale in which only whitelisted users can contribute.
 */
contract WhitelistCrowdsale is WhitelistedRole, Crowdsale {


    constructor(uint256 rate, address payable wallet, IERC20 token) Crowdsale(rate,wallet,address(token) ) public {

    }
    /**
     * @dev Extend parent behavior requiring beneficiary to be whitelisted. Note that no
     * restriction is imposed on the account sending the transaction.
 
     */
    /*function _preValidatePurchase(address _beneficiary, uint256 _weiAmount) internal view {
        require(isWhitelisted(_beneficiary), "WhitelistCrowdsale: beneficiary doesn't have the Whitelisted role");
        super._preValidatePurchase(_beneficiary, _weiAmount);
    }
    */
    function preValidatePurchaseAmount(address _beneficiary,uint PurchaseValue) internal{
        uint256 tokens = _getTokenAmount(PurchaseValue);
        require (isWhitelistedforAmount( _beneficiary, tokens), "WhitelistCrowdsale: beneficiary doesn't have the Whitelisted role for the correct amount");
        super._preValidatePurchase(_beneficiary,PurchaseValue);
        _decreaseTierPurchase(_beneficiary,tokens);
        
    }
}