import BuyTokens from './BuyTokens.js';
import { drizzleConnect } from 'drizzle-react'
const mapStateToProps = state => {
    return {
      accounts: state.accounts,
      contracts: state.contracts
    }
  }
const BuyTokensContainer = drizzleConnect(BuyTokens, mapStateToProps);

export default BuyTokensContainer