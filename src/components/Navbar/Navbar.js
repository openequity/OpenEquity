import React from 'react';
import './Navbar.css';
import { makeStyles } from '@material-ui/core/styles';
import Typography from '@material-ui/core/Typography';
import Link from '@material-ui/core/Link';
import { Link as Linkto } from "react-router-dom";
const useStyles = makeStyles((theme) => ({
  root: {
    '& > * + *': {
      marginLeft: theme.spacing(2),
    },
    color: 'white'
  },
}));

export default function Links() {
  const classes = useStyles();

  return (
    <Typography className={classes.root}>
      <Link component={Linkto} to="/DeployToken" color="inherit">DeployToken</Link>
      <Link component={Linkto} to="/deployCrowdsale" color="inherit">DeployCrowdSale</Link>
      <Link component={Linkto} to="/BuyTokens" color="inherit">BuyTokens</Link>
    </Typography>
  );
}