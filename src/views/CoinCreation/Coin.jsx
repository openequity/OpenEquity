import React,{Component} from 'react';

import PropTypes from "prop-types";
import withStyles from "@material-ui/core/styles/withStyles";
import Button from '@material-ui/core/Button';
import Card from '@material-ui/core/Card';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import Grid from '@material-ui/core/Grid';
import Typography from '@material-ui/core/Typography';

// core components
// import Button from "../../components/CustomButtons/Button";
import Input from "../input/Input"
import moment from 'moment'

class Coin extends Component {
  constructor(props, context) {
      super(props)
      console.log(props)

this.state={
accounts:props.accounts[0],
web3:'',
parametersSet:false,


  orderForm: {
    decimals: {
        elementType: 'input',
        label: 'decimal uints',
        elementConfig: {
            type: 'text',
            placeholder: 'enter decimal uints'
        },
        value: 10
    },
    CoinSymbol: {
        elementType: 'input',
        label: 'symbol',
        elementConfig: {
            type: 'text',
            placeholder: 'enter symbol'
        },
        value: 'TS'
    },
    CoinName: {
        elementType: 'input',
        label:'Coin Name',
        elementConfig: {
            type: 'text',
            placeholder: 'coin name'
        },
        value: 'Test'
    },
    CoinPrice: {
        elementType: 'input',
        label:'Coin Price',
        elementConfig: {
            type: 'text',
            placeholder: 'coin price'
        },
        value:1000
    },
    TotalSupply: {
        elementType: 'input',
        label:'Total Coin Supply',
        elementConfig: {
            type: 'text',
            placeholder: 'total coin supply'
        },
        value: 100000
    },
    FundingGoal: {
        elementType: 'input',
        label:'Funding Goal',
        elementConfig: {
            type: 'text',
            placeholder: 'Funding Goal'
        },
        value: 1000000000
    },
   UserstoAdmit: {
        elementType: 'input',
        label:'Users to Admit',
        elementConfig: {
            type: 'text',
            placeholder: 'Enter total Users'
        },
        value: 100
    },
    PublicShare: {
        elementType: 'input',
        label:'Public Share',
        elementConfig: {
            type: 'text',
            placeholder: 'enter public share percentage'
        },
        value: 10000
    },
    StartDate: {
        elementType: 'date',
        label:'Sale Start Date',
        elementConfig: {
            type: 'text',
            placeholder: ''
        },
        value: '',
        display:''
    },
    EndDate: {
      elementType: 'date',
      label:'Sale End Date',
      elementConfig: {
          type: 'text',
          placeholder: ''
      },
      value: '',
      display:''
    }



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
event:''
}
}



componentWillMount () {
  console.log(this.props)
  console.log(this.context)
  console.log(this.context.drizzle.contracts.CoinDeployer.events)
  this.setState({events:this.context.drizzle.contracts.CoinDeployer.events.CoinCreation})
}




handleChange = (fieldName, event) => {
  const state = {
    ...this.state,
  };
  state[fieldName] = event.target.value;
  this.setState(state);
  console.log(state)
};

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
handleSubmit2= async()=>{
    const formElementsArray = [];
    const partnerArray=[]
    const partnerShares=[]
    const NumParams=[]
    const author=this.state.accounts

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
    for (let key in this.state.orderForm) {
        formElementsArray.push({
            id: key,
            config: this.state.orderForm[key]
        });
    }
    // 0 decimals, 1 CoinSymbol 1 CoinName, 3 CoinPrice ,4 TotalSupply, 5 Goal,6 Users, 7Public Share,8 Start ,9 end
    console.log( formElementsArray)
    let tokenName=formElementsArray[1].config.value
    let tokenSymbol=formElementsArray[2].config.value
    NumParams.push(formElementsArray[5].config.value)//total supply
    NumParams.push(formElementsArray[6].config.value)
    NumParams.push(formElementsArray[8].config.display)//start
    NumParams.push(formElementsArray[9].config.display)//end
    NumParams.push(1)
    NumParams.push(1)
    NumParams.push(formElementsArray[3].config.value)
    NumParams.push(formElementsArray[0].config.value)
    let Decimal=formElementsArray[0].config.value
    console.log(Decimal)
    partnerShares.push(formElementsArray[4].config.value*10**Decimal)
    partnerShares.push(formElementsArray[7].config.value*10**Decimal)

    if(this.state.p1s.length>2){
        console.log(this.state.p1s.length)
    partnerShares.push(this.state.p1s)
    }
    if(this.state.p2s.length>2){
        console.log(this.state.p1s.length)
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
    console.log(partnerShares)
    console.log(NumParams)
    console.log(tokenName)
    console.log(tokenSymbol)
    console.log(this.state.contracts.CoinDeployer.methods.deployCoin)
    const stackId =await this.state.contracts.CoinDeployer.methods.deployCoin(author,tokenName,tokenSymbol,partnerShares,NumParams,partnerArray).send({
        from: this.state.accounts
      });
      
      console.log(stackId)
      console.log(await this.state.contracts.CoinDeployer.methods.getCoinLocation(1).call())
    //uint goal	numParams[0];
      //uint eligibleCount numParams[1];
	    //uint startdate numParams[2];
	    //uint enddate numParams[3];
      //uint   weightCoefficient numParams[4];
      //uint   weightCoefficient2 numParams[5];
      // uint price numParams[6];
      // decimal places numParams[7]
      // PartnerShares[0] founder coin, PartnerShares[1] coins for sale
       }
 handleSubmit=()=>{
    this.setState({parametersSet:true})
 }

render () {
    const formElementsArray = [];
    for (let key in this.state.orderForm) {
      formElementsArray.push({
          id: key,
          config: this.state.orderForm[key]
      });
    }
    const parametersForm =
      <React.Fragment>
        <Typography variant="display1" gutterBottom>
          Token Parameters
        </Typography>
        <form >
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
      </React.Fragment>
    const tokenPartnersForm =
        <div>
            <Typography variant="display1" gutterBottom>
              Token Partners
            </Typography>
            <form action="/action_page.php">
            <label>Partner 1:</label>
           <input type="text" style={{margin:"5px"}} placeholder="enter address" onChange={this.handleChange.bind(this,'partner1')}></input>
           <input type="text"style={{margin:"5px"}} placeholder="enter share"  onChange={this.handleChange.bind(this,'p1s')}></input>
           <br></br>
           <label>Partner 2:</label>
           <input type="text" style={{margin:"5px"}}  placeholder="enter address" onChange={this.handleChange.bind(this,'partner2')}></input>
           <input type="text"style={{margin:"5px"}} placeholder="enter share" onChange={this.handleChange.bind(this,'p2s')}></input>
           <br></br>
           <label>Partner 3:</label>
           <input type="text" style={{margin:"5px"}} placeholder="enter address" onChange={this.handleChange.bind(this,'partner3')}></input>
           <input type="text"style={{margin:"5px"}}  placeholder="enter share" onChange={this.handleChange.bind(this,'p3s')}></input>
           <br></br>
           <label>Partner 4:</label>
           <input type="text" style={{margin:"5px"}} placeholder="enter address" onChange={this.handleChange.bind(this,'partner4')}></input>
           <input type="text"style={{margin:"5px"}} placeholder="enter share" onChange={this.handleChange.bind(this,'p4s')}></input>
           <br></br>
           <label>Partner 5:</label>
           <input type="text" style={{margin:"5px"}} placeholder="enter address" onChange={this.handleChange.bind(this,'partner5')}></input>
           <input type="text"style={{margin:"5px"}} placeholder="enter share" onChange={this.handleChange.bind(this,'p5s')}></input>
           <br></br>
            </form>
        </div>;
    return (
      <Card>
        <CardContent>
          <Grid container spacing={0}>
            <Grid item xs={0} sm={6} style={{background:'white'}} >
              {parametersForm}
            </Grid>
            <Grid item xs={6} sm={6}>
              {tokenPartnersForm}
            </Grid>
          </Grid>
        </CardContent>
        <CardActions>
          <Button variant="contained" color="primary" onClick={this.handleSubmit2}>Mint Coin</Button>
        </CardActions>
      </Card>
    );
  }
}
Coin.contextTypes = {
    drizzle: PropTypes.object
  }
export default withStyles()(Coin);
