import React, { Component } from 'react';
import './BuyTokens.css';
import { Input as InputText, InputLabel } from '@material-ui/core';
import Input from "../Input/Input"
import PropTypes from "prop-types";
import withStyles from '@material-ui/core/styles/withStyles';
import moment from 'moment'
import Button from '@material-ui/core/Button';
import Card from '@material-ui/core/Card';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import Grid from '@material-ui/core/Grid';
import FinalizableCrowdsale from '../../artifacts/contracts_/FinalizableCrowdsale.json'

class BuyTokens extends Component {

  constructor(props, context){
    super(props);
    this.state = {
      accounts:props.accounts[0],
      web3:'',
      parametersSet:false,
      
      // orderForm: {
      //   StartDate: {
      //       elementType: 'date',
      //       label:'Sale Opening Time',
      //       elementConfig: {
      //           type: 'text',
      //           placeholder: ''
      //       },
      //       value: '',
      //       display:''
      //   },
      //   EndDate: {
      //     elementType: 'date',
      //     label:'Sale Closing Time',
      //     elementConfig: {
      //         type: 'text',
      //         placeholder: ''
      //     },
      //     value: '',
      //     display:''
      //   },
      //   Wallet: {
      //       elementType: 'input',
      //       label: 'Wallet',
      //       elementConfig: {
      //           type: 'text',
      //           placeholder: 'enter payable Wallet address'
      //       },
      //       value: props.accounts[0]
      //   },
      //   Token: {
      //       elementType: 'input',
      //       label: 'Token',
      //       elementConfig: {
      //           type: 'text',
      //           placeholder: 'token'
      //       },
      //       value: 'POP'
      //   },
      // },
      instance:'',
      owner:'',
      contracts:context.drizzle.contracts,
      web3:'',
      created:false,
      newContract:''
    };
  }

  // componentWillMount(){

    // console.log(this.props)
    // console.log(this.context.drizzle.contracts.CoinCreator.methods)
    // this.setState(
    //   { 
    //     deployedCrowdsales:this.context.drizzle.contracts.CoinCreator.deployedCrowdsales,
    //     web3:this.context.drizzle.web3
    //   }
    // )
    // await myToken.transfer(myCrowdsale.address, await myToken.totalSupply())
  // }
  // componentDidMount(){}
  // componentWillUnmount(){}
//0xd7e32372e1b3a82510FF0EDDcEEB46565Ba831D6
  // componentWillReceiveProps(){}
  // shouldComponentUpdate(){}
  // componentWillUpdate(){}
  // componentDidUpdate(){}
  inputChangedHandler = (event, inputIdentifier,inputType) => {
    console.log(inputIdentifier)
    console.log(event)
    console.log(inputType)
    const updatedOrderForm = {
        ...this.state.orderForm
    };
    const updatedFormElement = {
        ...updatedOrderForm[inputIdentifier]
    };

    if(inputType=='date'){
      let display=event
      let unix=moment(event).format('X')
      updatedFormElement.value=display
      updatedFormElement.display=unix
      updatedOrderForm[inputIdentifier] = updatedFormElement;
      this.setState({orderForm: updatedOrderForm});

    }else{
    updatedFormElement.value = event.target.value;
    updatedOrderForm[inputIdentifier] = updatedFormElement;
    console.log(event.target.value)
    this.setState({orderForm: updatedOrderForm},console.log(this.state));
    }
  }

  // change partner address, share
  handleChange = (fieldName, event) => {
    const state = {
      ...this.state,
    };
    state[fieldName] = event.target.value;
    this.setState(state);
    console.log(state)
  };

  // deploy
  handleSubmit2= async()=>{
    let web3 = this.context.drizzle.web3;
    var crowdsaleaddress = "0xd7e32372e1b3a82510FF0EDDcEEB46565Ba831D6"
    let abi = FinalizableCrowdsale.abi;
    console.log(abi)
    // var contract = new web3.eth.Contract( abi ).at( crowdsaleaddress )
    // console.log(contract)
    // console.log(this.context.drizzle.web3)
    // console.log(this.state.contracts.CoinCreator.methods)
    // console.log(this.state.contracts.CoinCreator.methods.deployedCrowdsales('0xd7e32372e1b3a82510FF0EDDcEEB46565Ba831D6', 0))
    // const stackId =await this.state.contracts.CoinCreator.methods.deployedCrowdsales('0xd7e32372e1b3a82510FF0EDDcEEB46565Ba831D6', 123).send({
    //   from: this.state.accounts
    // });
    
    // console.log(stackId)

    // for (let key in this.state.orderForm) {
    //     formElementsArray.push({
    //         id: key,
    //         config: this.state.orderForm[key]
    //     });
    // }
    // 0 decimals, 1 CoinSymbol 2 CoinName, 3 CoinPrice ,4 TotalSupply, 5 Goal,6 Users, 7Public Share,8 Start ,9 end
    
    // let _openingTime=formElementsArray[0].config.value
    // let _closingTime=formElementsArray[1].config.value
    // let _wallet=formElementsArray[2].config.value
    // let _token=formElementsArray[3].config.value
    
    // // console.log("########PARAMS###########")
    // // console.log(decimal)
    // // console.log(tokenSymbol)
    // // console.log(tokenName)
    // // console.log(coinPrice)
    // // console.log(partnerArray)
    // // console.log(partnerShares)
    // // console.log("########PARAMS###########")
    // const stackId =await this.state.contracts.CoinCreator.methods.deployCrowdsale(_openingTime,_closingTime,_wallet,_token).send({
    //   from: this.state.accounts
    // });
    
    // console.log(stackId)
  }


  render() {
    const { classes } = this.props;
    let parametersForm=null
    let tokenPartnersForm=null
    let CreatedMessage=null
    const formElementsArray = [];
    for (let key in this.state.orderForm) {
      formElementsArray.push({
          id: key,
          config: this.state.orderForm[key]
      });
    }
    parametersForm = 
      <form
      className='Crowdsale'
       noValidate autoComplete="off">
        <h1>
          Sales Parameters
        </h1>
        {formElementsArray.map(formElement => (
            <Input
            key={formElement.id}
            elementType={formElement.config.elementType}
            elementConfig={formElement.config.elementConfig}
            value={formElement.config.value}
            label={formElement.config.label}
            changed={(event) => this.inputChangedHandler(event, formElement.id,formElement.config.elementType)} />
        ))}
      </form>

    // if(this.state.created === true){
    //   CreatedMessage=(<div> <h1>Your new Coin has been created. Its address is {this.state.newContract} </h1>
    //   </div>)
    // }
    return (
      <Card>
        <CardContent>
          <Grid container spacing={0}>
            {/* {CreatedMessage} */}
            <Grid item xs='auto' sm={6} style={{background:'white'}} >
              {/* {parametersForm} */}
              {/* <Button variant="contained" color="primary" onClick={this.handleSubmit2}>Deploy Token</Button> */}
            </Grid>
            <Grid item xs={3} sm={6}>
              <CardActions>
                <Button variant="contained" color="primary" onClick={this.handleSubmit2}>Buy Tokens</Button>
              </CardActions>
            </Grid>
          </Grid>
        </CardContent>
      </Card>
    );
  }
}
BuyTokens.contextTypes = {
  drizzle: PropTypes.object
}
export default BuyTokens;