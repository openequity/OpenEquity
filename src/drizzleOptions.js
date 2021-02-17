
import CoinCreator from './artifacts/contracts_/CoinCreator.json'
const drizzleOptions = {
  web3: {
    block: false,
    fallback: {
      type: 'ws',
      // url: 'ws://127.0.0.1:8545'
      url: "wss://rinkeby.infura.io/ws",
    }
  },
  contracts: [CoinCreator],
}

export default drizzleOptions