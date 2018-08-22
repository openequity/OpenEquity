var HDWalletProvider = require("truffle-hdwallet-provider");
var mnemonic="zone indicate whip pause jump involve pottery leaf flavor expect narrow parrot";

module.exports = {
  networks: {
    rinkeby: {

      provider: function() {
          
        return new HDWalletProvider(mnemonic, "https://rinkeby.infura.io/v3/39ad63095ace4ca597faae06e0f68a3")
      },
      network_id: 3
    }
  }
};
