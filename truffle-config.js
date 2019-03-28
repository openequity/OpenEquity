require('dotenv').config();
const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');

const ropstenUrl = `https://ropsten.infura.io/${process.env.INFURA}`;
const rinkebyUrl = `https://rinkeby.infura.io/${process.env.INFURA}`;

module.exports = {
  networks: {
    development: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*',
      gas: 6721975,
      gasPrice: 2000000000,
    },
    ropsten: {
      provider() {
        return new HDWalletProvider(process.env.MNEMONIC, ropstenUrl, 0);
      },
      network_id: 3,
      gasPrice: Web3.utils.toWei('25', 'gwei'),
      gas: 8000000,
    },
    rinkeby: {
      provider() {
        return new HDWalletProvider('process.env.MNEMONIC', rinkebyUrl, 0);
      },
      network_id: 4,
      gasPrice: 2000000000,
      gas: 4712388,
    },
  },
  mocha: {
    useColors: true,
  },
  compilers: {
    solc: {
      version: '0.5.0',
      settings: {
        optimizer: {
          enabled: true,
          runs: 200,
        },
      },
    },
  },
};
