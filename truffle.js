var HDWalletProvider = require("truffle-hdwallet-provider");
var mnemonic="";
var NonceTrackerSubprovider = require("web3-provider-engine/subproviders/nonce-tracker")
const Web3 = require("web3");
const web3 = new Web3();
module.exports = {
  networks: {
    main: {

      provider: function() {
        var wallet=new HDWalletProvider(mnemonic, "https://mainnet.infura.io/sD5DX2vrQvMCwK9gjV59")
        var nonceTracker = new NonceTrackerSubprovider()
        wallet.engine._providers.unshift(nonceTracker)
        nonceTracker.setEngine(wallet.engine)
        return wallet
      },
      gas: 5000000,
      gasPrice: web3.toWei("5", "gwei"),
      network_id: 1,

    }
  }
};
