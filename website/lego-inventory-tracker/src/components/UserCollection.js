import styles from '../css/Usercollection.module.css'
import React, { Component } from 'react'
import axios from 'axios'
import {connect} from 'react-redux'

class UserCollection extends Component {
    constructor(props){
        super(props);
        this.state = {
            favorites: [],
            owned: []
        }
    }
    
    fetchFavorites(){
        axios.get(`${process.env.REACT_APP_API_ENDPOINT}/api/${this.props.type}/favorites`, {
            headers:{
                'Authorization': `Bearer ${this.props.auth.token}`
            }
        }).then((res) => {
            this.state.favorites = res.data.data;
        }).catch((err) => {
            console.log(err);
        });
    }
    
    fetchOwned(){
        axios.get(`${process.env.REACT_APP_API_ENDPOINT}/api/${this.props.type}/owned`, {
            headers:{
                'Authorization': `Bearer ${this.props.auth.token}`
            }
        }).then((res) => {
            this.state.owned = res.data.data;
        }).catch((err) => {
            console.log(err);
        });
    }

    render() {
        const CollectionComponent = this.props.component;
        return (
            <>
            <div id="favorites">
                    <h1 className={styles.marginLeft}>Favorites:</h1>
                    <CollectionComponent />
                </div>
                <div id="owned">
                    <h1 className={styles.marginLeft}>Collection:</h1>
                    <CollectionComponent />
            </div>
            </>
        )
    }
}
const mapState = state => ({
    auth: state.authToken
})
export default connect(mapState,null)(UserCollection);