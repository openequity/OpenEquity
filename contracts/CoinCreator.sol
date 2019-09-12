pragma solidity ^0.5.0;
import "./OEToken.sol";
import "./FinalizableCrowdsale.sol";



contract CoinCreator{
mapping(address=>address[]) public deployedTokens;
mapping(address=>address[]) public deployedCrowdsales;
constructor() public{

}

function deployToken(string memory _name,uint8 _decimals,string memory _symbol,address[] memory _partners, uint[] memory _shares ) public{
    OEToken TokenInstance=new OEToken(_name,_symbol,_decimals,_partners,_shares);
    deployedTokens[msg.sender].push(address(TokenInstance));
}

 function deployCrowdsale(uint256 _openingTime, uint256 _closingTime,uint256 _rate, address payable _wallet, IERC20 _token) public{
    FinalizableCrowdsale instance = new FinalizableCrowdsale(_openingTime,_closingTime,_rate,_wallet,_token,msg.sender);
    deployedCrowdsales[msg.sender].push(address(instance));
}





}