import styles from '../css/Usercollection.module.css'
import React, { Component } from 'react'
import axios from 'axios'
import {connect} from 'react-redux'
import {Modal} from '@material-ui/core'
import Input from '@material-ui/core/Input'
import {AddCard} from './cards'
import {TextField, Link, Button, Typography, CssBaseline, Container} from '@material-ui/core'

class UserCollection extends Component {
    constructor(props){
        super(props);
        this.state = {
            favorites: null,
            owned: null,
            openFavorite: false,
            openOwned: false,
            favoriteItem: null,
            ownedItem: null,
            favoriteQuantity: null,
            ownedQuantity: null
            
        }
    }
    componentDidMount(){
        this.fetchFavorites()
        this.fetchOwned()
    }
    addFavorite = (event) => {
        var urlString = this.props.type.split('s')
        if(this.props.type === "sets"){
            urlString = ['set']
        }
        event.preventDefault()
        axios({
            method: 'POST',
            url:process.env.REACT_APP_API_ENDPOINT+`/api/${urlString[0]}/wants?id=`+this.state.favoriteItem,
            headers: {
                "Authorization": `Bearer ${this.props.auth.token}`,
                "Content-Type": "application/json"
            },
            data: {
                quantity: this.state.favoriteQuantity

            }
        }).then((res) => {
            console.log('completed successfully')
        }).catch((err) => {
            this.setState({error: "Could not update favorites"})
        })
    }
    addOwned = (event) => {
        event.preventDefault()
        var urlString = this.props.type.split('s')
        if(this.props.type === "sets"){
            urlString = ['set']
        }
        axios({
            method: 'POST',
           
           url:process.env.REACT_APP_API_ENDPOINT+`/api/${urlString[0]}/owns?id=`+this.state.ownedItem,
            headers: {
                "Authorization": `Bearer ${this.props.auth.token}`,
                "Content-Type": "application/json"
            },
            data: {
                quantity: this.state.ownedQuantity,
                quantityInUse: 0
            }
        }).then((res) => {
            console.log('completed successfully')
        }).catch((err) => {
            this.setState({error: "Could not update owned"})
        })
    }

    fetchFavorites(){
        var urlString = this.props.type.split('s')
        if(this.props.type === "sets"){
            urlString = ['set']
            console.log('yes')
        } 
        axios.get(`${process.env.REACT_APP_API_ENDPOINT}/api/${urlString[0]}/wants`, {
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
        var urlString = this.props.type.split('s')
        if(this.props.type === "sets"){
            urlString = ['set']
        }
        axios.get(`${process.env.REACT_APP_API_ENDPOINT}/api/${urlString[0]}/owns`, {
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
        let errorMessage;
        if(this.state.error){
            errorMessage = <div className={styles.warning}>{this.state.error}</div>;
        }
        const CollectionComponent = this.props.component;
        return (
            <>
            <Modal aria-labelledby="modal-title"
                open={this.state.openFavorite}
                onClose={()=>this.setState({openFavorite: false})}>
                <div className={styles.paper}>
                    <h1 id="modal-title">Add new favorited brick to your collection:</h1>
                    <form onSubmit={this.addFavorite}>
                    <Container component="main" maxWidth="xs">
                    <CssBaseline />
                    {errorMessage}
                    <div className={styles.paper}>
                        <TextField
                            variant="outlined"
                            margin="normal"
                            required
                            fullWidth
                            id="favoriteID"
                            label="ID of item to favorite"
                            name="favoriteID"
                            autoComplete="favoriteID"
                            autoFocus
                            onChange={e => this.setState({
                                ...this.state,
                                favoriteItem: e.target.value
                            })}
                        />
                        <h1>Quantity: </h1>
                        <Input type="number"
                        // variant="outlined"
                        // margin="normal"
                        // required
                        // fullWidth
                        // id="favoriteQ"
                        // label="Favorite"
                        // name="favoriteQ"
                        // autoComplete="favoriteQ"
                        // autoFocus
                        onChange={e => this.setState({
                            ...this.state,
                            favoriteQuantity: e.target.value
                        })} />
                        <div className={styles.submitContainer}>
                            <Button
                                type="submit"
                                fullWidth
                                variant="contained"
                                color="primary"
                                className={styles.submit}
                            >
                                Add
                            </Button>
                        </div>
                    </div>
                    </Container>
                    </form>
                </div>
            </Modal>
            <Modal aria-labelledby="modal-title"
                open={this.state.openOwned}
                onClose={()=>this.setState({openOwned: false})}>
                <div className={styles.paper}>
                    <h1 id="modal-title">Add new brick to your collection:</h1>
                    <form onSubmit={this.addOwned}>
                    <Container component="main" maxWidth="xs">
                    <CssBaseline />
                    {errorMessage}
                    <div className={styles.paper}>
                        <TextField
                            variant="outlined"
                            margin="normal"
                            required
                            fullWidth
                            id="ownedIF"
                            label="Owned"
                            name="ownedID"
                            autoComplete="ownedID"
                            autoFocus
                            onChange={e => this.setState({
                                ...this.state,
                                ownedItem: e.target.value
                            })}
                        />
                        <h1>Quantity: </h1>
                        <Input type="number"
                        // variant="outlined"
                        // margin="normal"
                        // required
                        // fullWidth
                        // id="ownedQ"
                        // label="Owned item's ID"
                        // name="ownedQ"
                        // autoComplete="ownedQ"
                        // autoFocus
                        onChange={e => this.setState({
                            ...this.state,
                            ownedQuantity: e.target.value
                        })} />
                        <div className={styles.submitContainer}>
                            <Button
                                type="submit"
                                fullWidth
                                variant="contained"
                                color="primary"
                                className={styles.submit}
                            >
                                Add
                            </Button>
                        </div>
                    </div>
                    </Container>
                    </form>
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