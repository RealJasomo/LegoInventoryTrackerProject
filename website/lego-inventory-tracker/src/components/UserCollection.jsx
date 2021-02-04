import styles from '../css/Usercollection.module.css'
import React, { Component } from 'react'
import axios from 'axios'
import {connect} from 'react-redux'
import {Modal} from '@material-ui/core'
import {AddCard} from './cards'
class UserCollection extends Component {
    constructor(props){
        super(props);
        this.state = {
            favorites: [],
            owned: [],
            openFavorite: false,
            openOwned: false
        }
    }
    
    fetchFavorites(){
        axios.get(`${process.env.REACT_APP_API_ENDPOINT}/api/${this.props.type}/favorites`, {
            headers:{
                'Authorization': `Bearer ${this.props.auth.token}`
            }
        }).then((res) => {
            this.setState({favorites: res.data.data});
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
            this.setState({owned: res.data.data})
        }).catch((err) => {
            console.log(err);
        });
    }

    render() {
        const CollectionComponent = this.props.component;
        return (
            <>
            <Modal aria-labelledby="modal-title"
                open={this.state.openFavorite}
                onClose={()=>this.setState({openFavorite: false})}>
                <div className={styles.paper}>
                    <h1 id="modal-title">Add new favorited brick to your collection:</h1>
                </div>
            </Modal>
            <Modal aria-labelledby="modal-title"
                open={this.state.openOwned}
                onClose={()=>this.setState({openOwned: false})}>
                <div className={styles.paper}>
                    <h1 id="modal-title">Add new brick to your collection:</h1>
                </div>
            </Modal>
            <div id="favorites">
                    <h1 className={styles.marginLeft}>Favorites:</h1>
                    <div className={styles.flex}>
                        <AddCard onClick={()=>this.setState({openFavorite: true})} />
                        <CollectionComponent data={this.state.favorites}/>
                    </div>
                </div>
                <div id="owned">
                    <h1 className={styles.marginLeft}>Collection:</h1>
                    <div className={styles.flex}>
                        <AddCard onClick={()=>this.setState({openOwned: true})} />
                        <CollectionComponent data={this.state.owned}/>
                    </div>
            </div>
            </>
        )
    }
}
const mapState = state => ({
    auth: state.authToken
})
export default connect(mapState,null)(UserCollection);