import { Typography } from '@material-ui/core';
import React, { Component } from 'react';
import './TokenNet.css';
import InputLabel from '@material-ui/core/InputLabel';
import MenuItem from '@material-ui/core/MenuItem';
import Select from '@material-ui/core/Select';

import FormControl from '@material-ui/core/FormControl';

class TokenNet extends Component {
  constructor(props){
    super(props);
    this.state = {};
  }

  // componentWillMount(){}
  // componentDidMount(){}
  // componentWillUnmount(){}

  // componentWillReceiveProps(){}
  // shouldComponentUpdate(){}
  // componentWillUpdate(){}
  // componentDidUpdate(){}

  render() {
    return (
      <div>
        <h1 >
        Token Builder
        </h1>
        {/* <FormControl>
          <InputLabel id="label">Deploy and Sell your own ERC20 Token on the</InputLabel>
          <Select labelId="label" id="select" value="20">
            <MenuItem value="10">Ten</MenuItem>
            <MenuItem value="20">Twenty</MenuItem>
          </Select>
        </FormControl> */}
      </div>
    );
  }
}

export default TokenNet;