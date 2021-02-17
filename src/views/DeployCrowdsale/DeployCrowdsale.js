import React, { Component } from 'react';
import './DeployCrowdsale.css';
import Container from '@material-ui/core/Container';
import NoWallet from "../../components/NoWalllet"
import TokenNet from "../../components/TokenNet"
import CrowdsaleContainer from "../../components/Crowdsale/index.js"

class DeployCrowdsale extends Component {
  constructor(props){
    super(props);
    this.state = {
      wallet: 0
    };
  }

  // componentWillMount(){}
  // componentDidMount(){}
  // componentWillUnmount(){}

  // componentWillReceiveProps(){}
  // shouldComponentUpdate(){}
  // componentWillUpdate(){}
  // componentDidUpdate(){}

  render() {
    const isWallet = this.state.wallet;
    let ConnectWallet;
    if (!isWallet) {
      ConnectWallet = <NoWallet />;
    }
    else ConnectWallet = ''
    return (
      <Container>
        {/* { ConnectWallet } */}
        {/* <TokenNet /> */}
        <CrowdsaleContainer />
      </Container>
    );
  }
}

export default DeployCrowdsale;