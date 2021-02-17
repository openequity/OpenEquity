import Crowdsale from './Crowdsale.js';
import { drizzleConnect } from 'drizzle-react'
const mapStateToProps = state => {
    return {
      accounts: state.accounts,
      contracts: state.contracts
    }
  }
const CrowdsaleContainer = drizzleConnect(Crowdsale, mapStateToProps);

export default CrowdsaleContainer