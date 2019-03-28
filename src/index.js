import React from 'react';
import ReactDOM from 'react-dom';
import { Router, Route, Switch } from 'react-router'
import { DrizzleProvider } from 'drizzle-react'
import { setTiles, updatePalette } from './actions'
import { createMuiTheme, MuiThemeProvider } from '@material-ui/core/styles';
import blue from '@material-ui/core/colors/blue';
import green from '@material-ui/core/colors/green';

// Layouts
import { LoadingContainer } from 'drizzle-react-components'

import { history, store } from './store'
import drizzleOptions from './drizzleOptions'
import indexRoutes from "./routes/index.jsx";

//store.dispatch(setTiles());


const theme = createMuiTheme({
  palette: {
    primary: { main: green[900] },
    secondary: blue
  },
});

ReactDOM.render((
    <DrizzleProvider options={drizzleOptions} store={store}>
      <LoadingContainer>
        <MuiThemeProvider theme={theme}>
          <Router history={history}>
            <Switch>
              {indexRoutes.map((prop, key) => {
                return <Route path={prop.path} component={prop.component} key={key} />;
              })}
            </Switch>
          </Router>
        </MuiThemeProvider>
      </LoadingContainer>
    </DrizzleProvider>
  ),
  document.getElementById('root')
);
