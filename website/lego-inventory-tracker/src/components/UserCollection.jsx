import styles from '../css/Usercollection.module.css'
import React, { Component } from 'react'
import axios from 'axios'
import {connect} from 'react-redux'
import {Modal} from '@material-ui/core'
import Input from '@material-ui/core/Input'
import {AddCard} from './cards'
import InfiniteScroll from 'react-infinite-scroll-component'
import {SetCard} from './cards'

import {TextField, Link, Button, Typography, CssBaseline, Container} from '@material-ui/core'

class UserCollection extends Component {
    constructor(props){
        super(props);
        this.state = {
            favorites: [],
            owned: [],
            openFavorite: false,
            openOwned: false,
            favoriteItem: null,
            ownedItem: null,
            favoriteQuantity: 1,
            ownedQuantity: 1,
            quantityInUse: 0,
            error:"",
            data: [],
            page: 1,
            searchTarget: null,
            searchResults: null,
            id: '',
            showUpdateOwned: false,
            showUpdateFavorite: false
            
        }
    }
    componentDidMount(){
        this.fetchFavorites()
        this.fetchOwned()
        this.fetchSets()
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
                quantity: this.state.favoriteQuantity,
                id: this.state.favoriteItem

            }
        }).then((res) => {
            console.log('completed successfully')
            this.setState({openFavorite: false});
            this.fetchFavorites();
        }).catch((err) => {
            // this.setState({
            //     ...this.state,
            //     error: err.response.data.error
            // });
           this.setState({error: "Could not update favorites"})
        })
    }

    search = (event) => {
        var urlString = this.props.type.split('s')
        if(this.props.type === "sets"){
            urlString = ['set']
        }
        event.preventDefault()
        axios({
            method: 'POST',
            url:process.env.REACT_APP_API_ENDPOINT+`/api/${urlString[0]}/search`,//?name=`+this.state.searchTarget,
            headers: {
                "Authorization": `Bearer ${this.props.auth.token}`,
                "Content-Type": "application/json"
            },
            data: {
                name: this.state.searchTarget
            }
        }).then((res) => {
            console.log('completed successfully');
            this.setState({searchResults: res.data.data});
            console.log(res.data.data)
        }).catch((err) => {

           this.setState({error: "Could not complete search"})
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
                quantityInUse: this.state.quantityInUse,
                id: this.state.ownedItem
            }
        }).then((res) => {
            console.log('completed successfully')
            this.setState({openOwned: false});
            this.fetchOwned();
        }).catch((err) => {
            this.setState({error: "Could not update owned"})
        })
    }

    fetchFavorites(){
        var urlString = this.props.type.split('s')
        if(this.props.type === "sets"){
            urlString = ['set']
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

    fetchSets() {
        axios.get(process.env.REACT_APP_API_ENDPOINT+`/api/sets/${this.state.page}/50`)
        .then((res) => {
            this.setState({
                data: this.state.data.concat(res.data.data),
                page: this.state.page+1
            })
        })
        .catch((err) => {
            console.log(err);
        })
    }

    handleOwnedBrickClick = (id) => {
        return async (event) => {
            await this.setState({id: id});
            await this.setState({ownedQuantity: this.getDefaultOwned(), quantityInUse: this.getDefaultOwnedUse(), showUpdateOwned: true})
        }
    }
    handleFavoriteBrickClick = (id) => {
        return async (event) => {
            await this.setState({id: id})
            await this.setState({favoriteQuantity: this.getDefaultFavorite(), showUpdateFavorite: true});
        }
    }
    
    getDefaultOwnedUse = () => {
        if(this.props.type ==='sets')
            return this.state.owned.find(e => e.ID === this.state.id)?.QuantityBuilt;
        else
            return this.state.owned.find(e => e.ID === this.state.id)?.QuantityInUse;
    }

    getDefaultOwned = () => {
        return this.state.owned.find(e => e.ID === this.state.id)?.Quantity || this.state.ownedQuantity;
    }
    getDefaultFavorite = () => {
        return this.state.favorites.find(e => e.ID === this.state.id)?.Quantity || this.state.favoriteQuantity;
    }
    handleUpdateFavorite = () => {
        var urlString = this.props.type.slice(0,-1);
        axios({
            method: 'POST',
            url:process.env.REACT_APP_API_ENDPOINT+`/api/${urlString}/wants/update`,
            headers: {
                "Authorization": `Bearer ${this.props.auth.token}`,
                "Content-Type": "application/json"
            },
            data: {
                quantity: this.state.favoriteQuantity,
                id: this.state.id
            }
        }).then((res) => {
            console.log('completed successfully')
            this.setState({showUpdateFavorite: false});
            this.fetchFavorites();
        }).catch((err) => {
           this.setState({error: "Could not update favorites"})
        })
    }
    handleDelete = (route) => () => {
        var urlString = this.props.type.slice(0,-1);
        axios({
            method: 'DELETE',
            url:process.env.REACT_APP_API_ENDPOINT+`/api/${urlString}/${route}/delete`,
            headers: {
                "Authorization": `Bearer ${this.props.auth.token}`,
                "Content-Type": "application/json"
            },
            data: {
                id: this.state.id
            }
        }).then((res) => {
            console.log('completed successfully')
            if(route === 'wants'){
                this.setState({showUpdateFavorite: false});
                this.fetchFavorites();
            }else{
                this.setState({showUpdateOwned: false});
                this.fetchOwned();
            }
        }).catch((err) => {
           this.setState({error: "Could not delete favorites"})
        })
    }

    handleUpdateOwned = () => {
        var urlString = this.props.type.slice(0,-1);
        axios({
            method: 'POST',
            url:process.env.REACT_APP_API_ENDPOINT+`/api/${urlString}/owns/update`,
            headers: {
                "Authorization": `Bearer ${this.props.auth.token}`,
                "Content-Type": "application/json"
            },
            data: {
                quantity: this.state.ownedQuantity,
                quantityInUse: this.state.quantityInUse,
                id: this.state.id
            }
        }).then((res) => {
            console.log('completed successfully')
            this.setState({showUpdateOwned: false});
            this.fetchOwned();
        }).catch((err) => {
           this.setState({error: "Could not update favorites"})
        })
    }
    render() {
        let errorMessage;
        const sets = () =>{ 
            var data = this.props.data || this.state.data;
            return data.map((data, idx) => {
                return <SetCard key={idx} id={data.ID} url={data.ImageURL} color={data.Color} name={data.Name} quantityOwned={data.Quantity} quantityBuilt={data.QuantityBuilt}/>
            });
        }
        if(this.state.error){
            errorMessage = <div className={styles.warning}>{this.state.error}</div>;
        }
        const CollectionComponent = this.props.component;
        return (
            <>
            <Modal aria-labelledby="modal-title"
            open={this.state.showUpdateFavorite}
            onClose={()=>this.setState({showUpdateFavorite: false})}>
                <div className={styles.paper}>
                    <h1 id="modal-title">Update favorited {this.props.type.slice(0,-1)} {this.state.id}</h1>
                    <Container component="main" maxWidth="xs">
                    <CssBaseline />
                    <h1>Quantity: </h1>
                        <Input type="number"
                        defaultValue={this.state.favoriteQuantity}
                        onChange={e => this.setState({
                            ...this.state,
                            favoriteQuantity: e.target.value
                        })} />
                        <div className={styles.submitContainer}>
                            <Button
                                type="button"
                                fullWidth
                                variant="contained"
                                color="primary"
                                className={styles.submit}
                                onClick={this.handleUpdateFavorite}
                            >
                               update
                            </Button>
                            <Button
                                type="button"
                                fullWidth
                                variant="contained"
                                color="secondary"
                                className={styles.submit}
                                onClick={this.handleDelete('wants')}
                            >
                               delete
                            </Button>
                        </div>
                        </Container>
                </div>
            </Modal>
            <Modal aria-labelledby="modal-title"
            open={this.state.showUpdateOwned}
            onClose={()=>this.setState({showUpdateOwned: false})}>
                <div className={styles.paper}>
                    <h1 id="modal-title">Update Owned {this.props.type.slice(0,-1)} {this.state.id}</h1>
                    <Container component="main" maxWidth="xs">
                    <CssBaseline />
                    <h1>Quantity: </h1>
                        <Input type="number"
                        defaultValue={this.state.ownedQuantity}
                        onChange={e => this.setState({
                            ...this.state,
                            ownedQuantity: e.target.value
                        })} />
                     {this.props.type==='sets'?<h1>Quantity built:</h1>:<h1>Quantity in Use: </h1>}
                        <Input type="number"
                        defaultValue={this.state.quantityInUse}
                        onChange={e => this.setState({
                            ...this.state,
                            quantityInUse: e.target.value
                        })} />
                        <div className={styles.submitContainer}>
                            <Button
                                type="button"
                                fullWidth
                                variant="contained"
                                color="primary"
                                className={styles.submit}
                                onClick={this.handleUpdateOwned}
                            >
                               update
                            </Button>
                            <Button
                                type="button"
                                fullWidth
                                variant="contained"
                                color="secondary"
                                className={styles.submit}
                                onClick={this.handleDelete('owns')}
                            >
                               delete
                            </Button>
                        </div>
                    </Container>
                </div>
            </Modal>
            <Modal aria-labelledby="modal-title"
                open={this.state.openFavorite}
                onClose={()=>this.setState({openFavorite: false})}>
                <div className={styles.paper}>
                    <h1 id="modal-title">Add new {this.props.type.slice(0,-1)} to your wishlist:</h1>
                    <form onSubmit={this.addFavorite}>
                    <Container component="main" maxWidth="xs">
                    <CssBaseline />
                    
                    
                    {errorMessage}
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
                        defaultValue='1'
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
                    </Container>
                    </form>
                </div>
            </Modal>
            {/* Add new item to owned */}
            <Modal aria-labelledby="modal-title"
                open={this.state.openOwned}
                onClose={()=>this.setState({openOwned: false})}>
                <div className={styles.paper}>
                    <h1 id="modal-title">Add new {this.props.type.slice(0,-1)} to your collection:</h1>
                    <form onSubmit={this.addOwned}>
                    <Container component="main" maxWidth="xs">
                    <CssBaseline />
                    {errorMessage}
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
                        defaultValue='1'

                        onChange={e => this.setState({
                            ...this.state,
                            ownedQuantity: e.target.value
                        })} />
                        {this.props.type==='sets'?<h1>Quantity built:</h1>:<h1>Quantity in Use: </h1>}
                        <Input type="number"
                        defaultValue='0'

                        onChange={e => this.setState({
                            ...this.state,
                            quantityInUse: e.target.value
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
                    </Container>
                    </form>
                </div>
            </Modal>
            <div id="favorites">
                    <h1 className={styles.marginLeft}>Wishlist:</h1>
                    <div className={styles.flex}>
                        <AddCard onClick={()=>this.setState({openFavorite: true, favoriteQuantity:1})} />
                        <CollectionComponent data={this.state.favorites}  onChildClick={this.handleFavoriteBrickClick}/>
                    </div>
                </div>
                <div id="owned">
                    <h1 className={styles.marginLeft}>Collection:</h1>
                    <div className={styles.flex}>
                        <AddCard onClick={()=>this.setState({openOwned: true, ownedQuantity:1, quantityInUse:0})} />
                        <CollectionComponent data={this.state.owned} onChildClick={this.handleOwnedBrickClick} />
                    </div>
            </div>
                    <h1>List of {this.props.type}:</h1>
                    <form onSubmit={this.search}>
                    <Container component="main" maxWidth="xs">
                    <CssBaseline />
                    <div className={styles.searchBar}>
                    {errorMessage}
                        <TextField
                            variant="outlined"
                            margin="normal"
                            required
                            fullWidth
                            id="searchID"
                            label="Search"
                            name="searchID"
                            autoComplete="Search"
                            autoFocus
                            onChange={e => this.setState({
                                ...this.state,
                                searchTarget: e.target.value
                            })}
                        />
                        <div className={styles.submitContainer}>
                            <Button
                                type="submit"
                                fullWidth
                                variant="contained"
                                color="primary"
                                className={styles.submit}
                            >
                                Search
                            </Button>
                        </div>
                    </div>
                    </Container>
                    </form>
            {/* {<InfiniteScroll
            dataLength={this.props.data||this.state.data.length} 
            next={this.props.data?()=>{}:this.fetchSets.bind(this)}
            hasMore={true}
            loader={<h4>Loading...</h4>}
            endMessage={
                <p style={{ textAlign: 'center' }}>
                <b>Yay! You have seen it all</b>
                </p>
            }>
            <div className={styles.flex}>
                {sets()}
            </div>
            </InfiniteScroll>} */}
            <div id="searched">
                    <div className={styles.flex}>
                        {console.log(this.state.searchResults)}
                        <CollectionComponent data={this.state.searchResults}/>
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