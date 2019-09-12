pragma solidity ^0.5.0;

import "./ERC20Mintable.sol";
import "./ERC20Detailed.sol";

contract OEToken is ERC20Mintable,ERC20Detailed{
    address[] public partners;
    uint[] public shares;
    mapping(address=>bool) redeemed;

    constructor(string memory _name,string memory _symbol,uint8 decimals,address[] memory _partners,uint[] memory _shares) ERC20Detailed(_name,_symbol,decimals) public {

        partners = _partners;
        shares = _shares;

    }

    function getMyShare(uint partnerID) public {
        require(msg.sender==partners[partnerID]);
        require(redeemed[partners[partnerID]]==false);
        
        redeemed[partners[partnerID]]=true;
        _mint(msg.sender, shares[partnerID]);
    }
}