import React, { Component } from 'react';
import './DeployToken.css';
import Container from '@material-ui/core/Container';
import NoWallet from "../../components/NoWalllet"
import TokenNet from "../../components/TokenNet"
import TokenContainer from "../../components/Token/index.js"

class DeployToken extends Component {
  constructor(props, context){
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
        <TokenContainer />
      </Container>
    );
  }
}

export default DeployToken;