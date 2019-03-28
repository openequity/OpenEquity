import Coin  from './Coin'
import { drizzleConnect } from 'drizzle-react'

// May still need this even with data function to refresh component on updates for this contract.
const mapStateToProps = state => {
  return {
    accounts: state.accounts,
    contracts: state.contracts
  }
}

const CoinContainer = drizzleConnect(Coin, mapStateToProps);

export default CoinContainer