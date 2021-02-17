import React from 'react';
import ReactDOM from 'react-dom';
import { Router, Route, Switch } from 'react-router'
import { DrizzleProvider } from 'drizzle-react'
import { setTiles, updatePalette } from './actions'
import { createMuiTheme, MuiThemeProvider } from '@material-ui/core/styles';
import blue from '@material-ui/core/colors/blue';
import green from '@material-ui/core/colors/green';

// Layouts
import { LoadingContainer, AccountData } from 'drizzle-react-components'

import { history, store } from './store'
import drizzleOptions from './drizzleOptions'
// import indexRoutes from "./routes/index.jsx";

import Header from './components/Header'
import DeployToken from './views/DeployToken'
import DeployCrowdsale from './views/DeployCrowdsale'
import BuyTokens from './views/BuyTokens'
//store.dispatch(setTiles());


const theme = createMuiTheme({
  palette: {
    primary: { main: green[900] },
    secondary: blue
  },
});

ReactDOM.render(
  <React.Fragment>
    <DrizzleProvider options={drizzleOptions} store={store}>
      <LoadingContainer>
        <MuiThemeProvider theme={theme}>
          <Router  history={history}>
            <Header />
            <Switch>
              <Route path="/DeployToken"  component={DeployToken} />
              <Route path="/DeployCrowdsale"  component={DeployCrowdsale} />
              <Route path="/BuyTokens"  component={BuyTokens} />
            </Switch>
          </Router>
        </MuiThemeProvider>
      </LoadingContainer>
    </DrizzleProvider>
  </React.Fragment>,
  document.getElementById('root')
);
