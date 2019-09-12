pragma solidity ^0.5.0;

import "./Roles.sol";
import "./WhitelistAdminRole.sol";

/**
 * @title WhitelistedRole
 * @dev Whitelisted accounts have been approved by a WhitelistAdmin to perform certain actions (e.g. participate in a
 * crowdsale). This role is special in that the only accounts that can add it are WhitelistAdmins (who can also remove
 * it), and not Whitelisteds themselves.
 */
contract WhitelistedRole is WhitelistAdminRole {
    using Roles for Roles.Role;

    event WhitelistedAdded(address indexed account);
    event WhitelistedRemoved(address indexed account);

    Roles.Role private _whitelisteds;

    modifier onlyWhitelisted() {
        require(isWhitelisted(msg.sender), "WhitelistedRole: caller does not have the Whitelisted role");
        _;
    }
    modifier onlyWhitelistedForAmount(uint purchaseValue) {
        require(isWhitelistedforAmount(msg.sender,purchaseValue), "WhitelistedRole: caller does not have the Whitelisted role");
        _;
    }

    function isWhitelisted(address account) public view returns (bool) {
        return _whitelisteds.has(account);
    }
      function isWhitelistedforAmount(address account,uint value) public view returns (bool) {
        return (_whitelisteds.hasAmount(account)>=value);
    }

    function addWhitelisted(address account,uint purchase) public onlyWhitelistAdmin {
        _addWhitelisted(account,purchase);
    }
    function increaseWhiteListingTier(address account,uint purchaseTier) public onlyWhitelistAdmin {
        _increaseTierPurchase( account, purchaseTier);
    }
     function decreaseWhiteListingTier(address account,uint purchaseTier) public onlyWhitelistAdmin {
        _decreaseTierPurchase( account, purchaseTier);
    }
    function removeWhitelisted(address account) public onlyWhitelistAdmin {
        _removeWhitelisted(account);
    }
    function getPurchasePower(address account) public view returns(uint){
        return _whitelisteds.hasAmount(account);
    }

    function renounceWhitelisted() public {
        _removeWhitelisted(msg.sender);
    }

    function _addWhitelisted(address account,uint purchase) internal {
        _whitelisteds.add(account,purchase);
        emit WhitelistedAdded(account);
    }

    function _removeWhitelisted(address account) internal {
        _whitelisteds.remove(account);
        emit WhitelistedRemoved(account);
    }
    function _increaseTierPurchase(address account,uint purchase) internal{
         _whitelisteds.increaseAmount(account,purchase);
    }
    function _decreaseTierPurchase(address account,uint purchase) internal{
         _whitelisteds.decreaseAmount(account,purchase);
    }
}