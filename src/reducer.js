import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'
import { drizzleReducers } from 'drizzle'
import color from '@material-ui/core/colors/amber';
import axios from 'axios'



const tiles = (state = [], action) => {
  switch(action.type) {
    case 'UPDATE_TILE':
      return [
        ...state.slice(0, action.tile.tileId - 1),
        action.tile,
        ...state.slice(action.tile.tileId,)
      ]
    case 'SET_TILES':
      return action.tiles;
    default:
      return state;
  }
}

const palette = (state = null, action) => {
  switch (action.type) {
    case 'UPDATE_PALETTE':
      console.log('test1')
      return action.colors;
    default:
      return state;
  }
}

const reducer = combineReducers({
  routing: routerReducer,
  ...drizzleReducers,
  palette: palette,
  tiles: tiles
})

export default reducer
