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



pragma solidity ^0.4.15;

//import "./Stoppable.sol";
//import "./Coin.sol";
//import "./Math.sol";

contract CoinPub  {
    //using Math for *;
    uint CoinID;            //ID applied to Coin upon pub, incrementing after each new Coin

    address CoinDeploy;
    address owner;
    uint DeployTime;
    function CoinPub(address C){
        CoinID = 0;

        CoinDeploy=C;

        owner=msg.sender;
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
    mapping(address=>uint[]) createdCoinIDs;
    mapping(address => Author) authors;
    mapping(uint => CoinStruct) Coins;
    mapping(uint=>uint[]) PartnerArray;
    //mapping(uint => address) CoinInstances;
    mapping(uint => address) getPartner;
    mapping(uint=>bool) isPartner;
    mapping(uint=>mapping(uint=>uint)) partnerShares;
    mapping(address=>uint) QueuedCoin;
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
                   //Global Coin ID ++1
      address authorAddress;       //Who was the author? Can be used to access Authors mapping
      uint _CoinID;
     
	    string tokenName;
	    string tokenSymbol;
	    string governanceModel;
      uint[] PartnerShares;
      uint[] NumParams;
      address[] PartnerArray;
         
      
      
      
      //uint goal	numParams[0];
      //uint eligibleCount numParams[1];
	    //uint startdate numParams[2];
	    //uint enddate numParams[3];
      //uint   weightCoefficient numParams[4];
      //uint   weightCoefficient2 numParams[5];
      // uint price numParams[6];
      // decimal uints numParams[7]
	  //How much equity did the author provision for customers?
      }
   /* function addPartner(uint _CoinID,uint8 _share,address p){
      require(isPartner[_CoinID]==false);
      uint i=Coins[CoinID].numPartners;
	    partnerShares[_CoinID][i]=_share;
      isPartner[_CoinID]=true;
      Coins[_CoinID].Shares.push(_share);
      PartnerArray.push(p);
      
    }
    */
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



    function createCoinStruct (uint _customershipStake,string _tokenName,string _tokenSymbol,string _governanceModel,uint[] _NumParams,uint[] _PartnerShares,address[] _PartnerArray)
      isAuthor() {
       CoinID += 1;
		   uint t=10;
       QueuedCoin[msg.sender]=CoinID;
       //uint[] memory P = new uint[](10);//default 10 possible partners (possibly add option for more or less)
		   //uint[]  P;
		   //P[1]=12;


        Coins[CoinID] = CoinStruct({
              
              authorAddress: msg.sender,
              _CoinID:CoinID,
              tokenName:_tokenName,
              tokenSymbol:_tokenSymbol,
							governanceModel:_governanceModel,
               PartnerShares: _PartnerShares,
               NumParams:_NumParams,
               PartnerArray: _PartnerArray
							
            });
      }
  

  function publishCoin() {

  CoinStruct id= Coins[QueuedCoin[msg.sender]];

   

    if(!CoinDeploy.call(bytes4(sha3(("deployCoin( address,uint,string, string ,uint[],uint[],address[])"))),id.authorAddress,id._CoinID,id.tokenName,id.tokenSymbol,id.PartnerShares,id.NumParams,id.PartnerArray  )) revert();


   }


  // function getCoinStruct(uint n) public  returns (CoinStruct) {
    // return Coins[n];
   //}
  /* function getStructDetails(uint n) returns(string,string,uint,uint,uint,uint,uint){
     CoinStruct memory b= Coins[n];
     return();
 }
 */

  function getPartnerShare(uint n,uint m) public  returns (uint) {
    return  partnerShares[n][m];
  }

 
  function getQueuedCoin() constant returns(uint){
    
    return  QueuedCoin[msg.sender];

  }
  function getCoins(address a) constant returns(uint[]){
    return createdCoinIDs[a];
  }

}
