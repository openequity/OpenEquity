import { drizzleConnect } from 'drizzle-react'
import Token from './Token.js';
const mapStateToProps = state => {
    return {
      accounts: state.accounts,
      contracts: state.contracts
    }
  }
const TokenContainer = drizzleConnect(Token, mapStateToProps);

export default TokenContainer