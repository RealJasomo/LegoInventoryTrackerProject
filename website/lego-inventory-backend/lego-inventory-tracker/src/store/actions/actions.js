import { SET_TOKEN } from './actionTypes'

export const setToken =  token =>  ({
        type: SET_TOKEN,
        info: 'Set user auth token',
        payload: {
            token
        }
    })