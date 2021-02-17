import React, { Component } from 'react';
import './Token.css';
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
import TokenContract from '../../artifacts/contracts/OEToken.json'

const styles = theme => ({
  root: {
    marginTop: '3ch',
    '& > *': {
      margin: theme.spacing(1),
      width: '25ch',
      marginBottom: '3ch'
    },
  },
});

class Token extends Component {
  constructor(props, context){
    super(props);
    this.state = {
      accounts:props.accounts[0],
      web3:'',
      parametersSet:false,
      
      orderForm: {
        Decimals: {
            elementType: 'input',
            label: 'Decimal uints',
            elementConfig: {
                type: 'text',
                placeholder: 'enter decimal uints'
            },
            value: 10
        },
        CoinSymbol: {
            elementType: 'input',
            label: 'Symbol',
            elementConfig: {
                type: 'text',
                placeholder: 'enter symbol'
            },
            value: 'POP'
        },
        CoinName: {
            elementType: 'input',
            label:'Coin Name',
            elementConfig: {
                type: 'text',
                placeholder: 'coin name'
            },
            value: 'Vox'
        },
        CoinPrice: {
            elementType: 'input',
            label:'Coin Price',
            elementConfig: {
                type: 'text',
                placeholder: 'coin price'
            },
            value:1600
        },
        TotalSupply: {
            elementType: 'input',
            label:'Total Coin Supply',
            elementConfig: {
                type: 'text',
                placeholder: 'total coin supply'
            },
            value: 10000
        },
      //   FundingGoal: {
      //       elementType: 'input',
      //       label:'Funding Goal',
      //       elementConfig: {
      //           type: 'text',
      //           placeholder: 'Funding Goal'
      //       },
      //       value: 6497000000
      //   },
      // UserstoAdmit: {
      //       elementType: 'input',
      //       label:'Users to Admit',
      //       elementConfig: {
      //           type: 'text',
      //           placeholder: 'Enter total Users'
      //       },
      //       value: 100
      //   },
      //   PublicShare: {
      //       elementType: 'input',
      //       label:'Public Share',
      //       elementConfig: {
      //           type: 'text',
      //           placeholder: 'enter public share percentage'
      //       },
      //       value: 10000
      //   },
      //   StartDate: {
      //       elementType: 'date',
      //       label:'Sale Start Date',
      //       elementConfig: {
      //           type: 'text',
      //           placeholder: ''
      //       },
      //       value: '',
      //       display:''
      //   },
      //   EndDate: {
      //     elementType: 'date',
      //     label:'Sale End Date',
      //     elementConfig: {
      //         type: 'text',
      //         placeholder: ''
      //     },
      //     value: '',
      //     display:''
      //   }
      },
      instance:'',
      owner:'',
      contracts:context.drizzle.contracts,
      partner1:'',
      partner2:'',
      partner3:'',
      partner4:'',
      partner5:'',
      p1s:'',
      p2s:'',
      p3s:'',
      p4s:'',
      p5s:'',
      event:'',
      web3:'',
      created:false,
      newContract:''
    };
  }

  componentWillMount(){

    // console.log(this.props)
    // console.log(this.context)
    this.setState(
      { 
        deployedTokens:this.context.drizzle.contracts.CoinCreator.deployedTokens,
        deployedCrowdsales:this.context.drizzle.contracts.CoinCreator.deployedCrowdsales,
        web3:this.context.drizzle.web3}
    )
  }
  // componentDidMount(){}
  // componentWillUnmount(){}

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
    const formElementsArray = [];
    const partnerArray=[]
    const partnerShares=[]
    const NumParams=[]

    if(this.state.partner1.length>1){
    partnerArray.push(this.state.partner1)
    }
    if(this.state.partner2.length>1){
    partnerArray.push(this.state.partner2)
    }
    if(this.state.partner3.length>1){
    partnerArray.push(this.state.partner3)
    }
    if(this.state.partner4.length>1){
    partnerArray.push(this.state.partner4)
    }
    if(this.state.partner5.length>1){
    partnerArray.push(this.state.partner5)
    }
    
    if(this.state.p1s.length>2){
    partnerShares.push(this.state.p1s)
    }
    if(this.state.p2s.length>2){
    partnerShares.push(this.state.p2s)
    }
    if(this.state.p3s.length>2){
    partnerShares.push(this.state.p3s)
    }
    if(this.state.p4s.length>2){
    partnerShares.push(this.state.p4s)
    }
    if(this.state.p5s.length>2){
    partnerShares.push(this.state.p5s)
    }

    for (let key in this.state.orderForm) {
        formElementsArray.push({
            id: key,
            config: this.state.orderForm[key]
        });
    }
    // 0 decimals, 1 CoinSymbol 2 CoinName, 3 CoinPrice ,4 TotalSupply, 5 Goal,6 Users, 7Public Share,8 Start ,9 end
    
    let decimal=formElementsArray[0].config.value
    let tokenSymbol=formElementsArray[1].config.value
    let tokenName=formElementsArray[2].config.value
    let coinPrice=formElementsArray[3].config.value
    
    // console.log("########PARAMS###########")
    // console.log(decimal)
    // console.log(tokenSymbol)
    // console.log(tokenName)
    // console.log(coinPrice)
    // console.log(partnerArray)
    // console.log(partnerShares)
    // console.log("########PARAMS###########")
    const stackId =await this.state.contracts.CoinCreator.methods.deployToken(tokenName,decimal,tokenSymbol,partnerArray, partnerShares).send({
      from: this.state.accounts
    });
    
    // console.log(stackId)
    let newaddress=stackId.events[0].address
    console.log(newaddress)
    // console.log(this.state.web3)
                   
    if(newaddress!=='0x0000000000000000000000000000000000000000'){ 
        var contractConfig = {
        contractName: newaddress,
        web3Contract: new this.state.web3.eth.Contract(TokenContract.abi,newaddress)
      }
      let events=['Transfer']
      // console.log(contractConfig)
      // console.log(this.context.drizzle)
      this.context.drizzle.addContract(contractConfig, events)
      this.setState({created:true,newContract:newaddress})
      let shareId = []
      console.log(partnerArray);
      console.log(partnerShares);
      for (let index = 0; index < partnerShares.length; index++) {
        shareId[index] =await this.state.contracts[newaddress].methods.getMyShare(index).send({from:this.state.accounts});
      }
      console.log(shareId)
    } 
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
      className="Token"
      //  className={classes.root} 
       noValidate autoComplete="off">
        <h1>
          Token Parameters
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
    tokenPartnersForm = 
      <form 
      className="Token"
        // className={classes.root} 
        noValidate autoComplete="off">
        <h1>
          Token Partners
        </h1>
        <InputLabel>Partner 1:</InputLabel>
        <InputText placeholder="enter address" onChange={this.handleChange.bind(this,'partner1')}></InputText>
        <InputText placeholder="enter share" onChange={this.handleChange.bind(this,'p1s')}></InputText>
        <InputLabel>Partner 2:</InputLabel>
        <InputText placeholder="enter address" onChange={this.handleChange.bind(this,'partner2')}></InputText>
        <InputText placeholder="enter share" onChange={this.handleChange.bind(this,'p2s')}></InputText>
        <InputLabel>Partner 3:</InputLabel>
        <InputText placeholder="enter address" onChange={this.handleChange.bind(this,'partner3')}></InputText>
        <InputText placeholder="enter share" onChange={this.handleChange.bind(this,'p3s')}></InputText>
        <InputLabel>Partner 4:</InputLabel>
        <InputText placeholder="enter address" onChange={this.handleChange.bind(this,'partner4')}></InputText>
        <InputText placeholder="enter share" onChange={this.handleChange.bind(this,'p4s')}></InputText>
        <InputLabel>Partner 5:</InputLabel>
        <InputText placeholder="enter address" onChange={this.handleChange.bind(this,'partner5')}></InputText>
        <InputText placeholder="enter share" onChange={this.handleChange.bind(this,'p5s')}></InputText>
      </form>
    if(this.state.created === true){
      CreatedMessage=(<div> <h1>Your new Coin has been created. Its address is {this.state.newContract} </h1>
      </div>)
    }
    return (
      <Card>
        <CardContent>
          <Grid container spacing={0}>
          {CreatedMessage}
            <Grid item xs='auto' sm={6} style={{background:'white'}} >
              {parametersForm}
            </Grid>
            <Grid item xs={6} sm={6}>
              {tokenPartnersForm}
              <CardActions>
                <Button variant="contained" color="primary" onClick={this.handleSubmit2}>Deploy Token</Button>
              </CardActions>
            </Grid>
          </Grid>
        </CardContent>
      </Card>
    );
  }
}
Token.contextTypes = {
  drizzle: PropTypes.object
}
// export default withStyles(styles)(Token);
export default Token;