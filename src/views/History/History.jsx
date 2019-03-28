import React from "react";
import PropTypes from "prop-types";
// @material-ui/core components
import withStyles from "@material-ui/core/styles/withStyles";
// core components
import Card from "../../components/Card/Card";
import CardHeader from "../../components/Card/CardHeader";
import CardBody from "../../components/Card/CardBody";
import GridItem from "../../components/Grid/GridItem.jsx";
import GridContainer from "../../components/Grid/GridContainer.jsx";

import historyStyles from "../../assets/jss/texel-tiles/views/historyStyles";

class History extends React.Component {
  constructor(props, context) {
    super(props)
    console.log(props)
    console.log(context)
    this.contracts = context.drizzle.contracts
  }
  
  render() {
  
    const { classes } = this.props;
    return (
      <div>
        <GridContainer>
          <GridItem xs={6} sm={6} md={6}>
            <h1>Display transaction history.</h1>
          </GridItem>
        </GridContainer>
        <GridContainer>
          <GridItem xs={6} sm={6} md={6}>
            <Card>
              <CardHeader color="primary">
                <h4 className={classes.cardTitleWhite}>Recent Paintings</h4>
              </CardHeader>
              <CardBody>
                <h5>List of recent paints</h5>
              </CardBody>
            </Card>
          </GridItem>
          <GridItem xs={6} sm={6} md={6}>
            <Card>
              <CardHeader color="primary">
                <h4 className={classes.cardTitleWhite}>Recent Rentals</h4>
              </CardHeader>
              <CardBody>
                <h5>List of recent rentals</h5>
              </CardBody>
            </Card>
          </GridItem>
        </GridContainer>
      </div>
    )
  }
}

History.contextTypes = {
  drizzle: PropTypes.object
}

export default withStyles(historyStyles)(History);
