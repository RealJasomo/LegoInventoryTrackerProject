import { SET_TOKEN } from '../actions/actionTypes'

const initialState = {
    authToken: ''
}

const reducer = (state = initialState, action) => {
    switch(action.type){
        case SET_TOKEN: return {
            authToken: action.payload
        }
        default: return state
    }
}

export default reducer;