
import Coin from '../build/contracts/Coin.json'
import CoinDeployer from '../build/contracts/CoinDeployer.json'
const drizzleOptions = {
  web3: {
    block: false,
    fallback: {
      type: 'ws',
      url: 'ws://127.0.0.1:9545'
    }
  },
  contracts: [CoinDeployer,Coin],
  events: {
    CoinDeployer: ['CoinCreation'],
  },
  polls: {}
}

export default drizzleOptions