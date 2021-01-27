import {createStore} from 'redux'
import reducer from './reducers/reducer'
import {saveState, loadState} from './local'

const state = loadState();
const store = createStore(reducer, state, window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__());

store.subscribe(() => {
    saveState(store.getState())
})
export default store;

