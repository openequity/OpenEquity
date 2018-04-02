//CoinStructPub - Decentralized CoinStruct Self-Publishing Platform
//Must work for many, many authors
//Assume authors might have as many as 10,000,000 fans
//Gonna be sweet!
//------------------------------------------------------*

/* Summary:
// Authors fund Coin publishing by selling licensing equity via micro crowd funding
1) Publish contract with initial supply of 0 and sell coins at fixed price
2) customers purchase coins to reveal eCoin download, and get in line for a hard copy
3) Any amount of coins purchased is acceptable, price as low as a penny if you like
4) The more coins you hold, the higher in line you get to receive your hard copy
5) Every coin you own represents a small piece of equity in licensing rights
6) Equity is determined by the number of coins you hold in proportion to total supply
7) When certain funding goals are met, users at the top of the line are shipped a hard copy
8) Coin holders are legally entitled to licesnsing revenue if a deal is made with a publisher, movie studio, amusementpark, etc.
*/

/*MAY NOT COMPILE*/

pragma solidity ^0.4.15;

import "./Stoppable.sol";
import "./Coin.sol";

contract CoinPub is Stoppable {
    uint CoinID;            //ID applied to Coin upon pub, incrementing after each new Coin

    function CoinPub(){
        CoinID = 0;
      }
    modifier isOwner() {
      require(msg.sender == owner);
      _;}           //Owner of CoinStructPub Platform
    modifier isAuthor() {
      //  require(authors[msg.sender].totalEarned == 0);
      _;}                                          //Author exists in Author mapping
    modifier iscustomer() {
      //    require(customers[msg.sender].customerUsername);
      _;}                                          //customer exists in customer mapping

    mapping(address => customer) customers;
    mapping(address => Author) authors;
    mapping(uint => CoinStruct) Coins;
    //mapping(uint => uint) partnerShares;
    mapping(uint=>mapping(uint=>uint)) partnerShares;
    //customer details [customersUsername, CoinIDs purchased array]
    struct customer {
      bytes customerUsername;      //customer's username
      bool eligible;
      //uint[] CoinsPurchased;       //CoinStructIDs of all owned Coins
      }
    //Author details [authorName, totalEarned, CoinID published array]
    struct Author {
       bytes authorName;          //Author's legal name
       uint totalEarned;            //How much has this writer earned?
       //uint[] CoinsPublished;       //CoinStructIDs of all published Coins
      }

    //CoinStruct details [CoinID, authorAddress, customershipStake, customers array]
    struct CoinStruct {
      uint CoinID;                 //Global Coin ID ++1
      address authorAddress;       //Who was the author? Can be used to access Authors mapping
      uint customershipStake;
      //uint[] Partners;
      uint numPartners;
      uint goal	;
      uint eligibleCount;
	    uint startdate;
	    uint enddate;

	    string tokenName;
	    string tokenSymbol;
	    string governanceModel;
	  //How much equity did the author provision for customers?
      }
    function addPartner(uint _CoinID,uint _share){
      uint i=Coins[CoinID].numPartners;
	    partnerShares[_CoinID][i]=_share;

      Coins[_CoinID].numPartners=i+1;
    }
    function becomecustomer(bytes _customerUsername) {
      //customer signs up to buy Coin coins
      customers[msg.sender] = customer({
                                  customerUsername: _customerUsername,
                                  eligible: false
                                  });
                                }
    function becomeAuthor(bytes _authorName) {
      //Author signs up to publish
      authors[msg.sender] = Author({
                                  authorName: _authorName,
                                  totalEarned: 0
                                  });
                                }



    function createCoinStruct (uint _customershipStake,string _tokenName,string _tokenSymbol,string _governanceModel)
      isAuthor() {
       CoinID += 1;
		   uint t=10;
       //uint[] memory P = new uint[](10);//default 10 possible partners (possibly add option for more or less)
		   //uint[]  P;
		   //P[1]=12;


        Coins[CoinID] = CoinStruct({
              CoinID: CoinID,
              authorAddress: msg.sender,
              customershipStake: _customershipStake,
              tokenName:_tokenName,
              tokenSymbol:_tokenSymbol,
							governanceModel:_governanceModel,
							goal:t,
						  startdate:t,
	 						enddate:t,
	 						eligibleCount:t,
						               //	Partners:P,
              numPartners:0

                            });
                          }
  function modifyCoinStruct(uint _CoinID,uint _goal,uint _startdate,uint _enddate,uint _eligibleCount)
	 isAuthor()   {
	              CoinStruct storage temp=Coins[_CoinID];
	              temp.goal=_goal;
	              temp.startdate=_startdate;
	              temp.enddate=_enddate;
	              temp.eligibleCount=_eligibleCount;

      //bytes data=0xa50b4f0;
      publishCoin( _CoinID ,  uint8(1000), uint(1000),  uint(0) );
   }

  function publishCoin(uint id, uint8 _decimalUnits,uint _initialAmount, uint _toBeShipped ){
     CoinStruct memory temp=Coins[id];

     Coin newCoin = new Coin(msg.sender, temp.customershipStake, temp.goal, _toBeShipped,
                             temp.eligibleCount, _initialAmount, temp.tokenName,_decimalUnits,temp.startdate,temp.enddate,temp.tokenSymbol);
   }

   function structRet(uint n)  public returns(uint){
     CoinStruct memory b= Coins[n];
     return b.customershipStake;

   }
   function nameret(uint n)  public returns(string){
     CoinStruct memory b= Coins[n];
     return b.tokenName;

   }
   function symbolret(uint n)  public returns(string){
     CoinStruct memory b= Coins[n];
     return b.tokenSymbol;

   }
   function getCoinStruct(uint n) public  returns (CoinStruct) {
     return Coins[n];
   }
   function getOtherparams(uint n) returns(uint,uint,uint,uint){
     CoinStruct memory b= Coins[n];
     return(b.goal,b.startdate,b.enddate,b.eligibleCount);

 }
  function getPartnerShare(uint n,uint m) public  returns (uint) {
    return  partnerShares[n][m];
  }
  function returnallShares(uint n) public returns (uint[]){
    CoinStruct memory B=Coins[n];
    uint sz=B.numPartners;
    uint[] memory P = new uint[](sz);
    for(uint i=0;i<sz;i++){
    P[i]=getPartnerShare(n,i);

  }
  return P;
}
}