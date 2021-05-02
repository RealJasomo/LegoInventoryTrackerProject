import styles from '../../css/Collection.module.css'
import React, { Component } from 'react'
import {SetCard} from '../cards'
import axios from 'axios'
import PropTypes from 'prop-types'
import InfiniteScroll from 'react-infinite-scroll-component'


export default class SetCollection extends Component {
    // static propTypes = {
    //     data: PropTypes.array
    // }
    constructor(props){
        super(props);
        this.state = {
            data: [],
            page: 1,
            loading: true
        }
    }   
    
    componentDidMount(){
        this.fetchSets();
    }

    fetchSets() {
        axios.get(`/api/sets/${this.state.page}/50`)
        .then((res) => {
           if(!res.data.data || res.data.data.length < 50){
                this.setState({loading: false});
           }
            this.setState({
                data: this.state.data.concat(res.data.data),
                page: this.state.page+1
            })
        })
        .catch((err) => {
            console.log(err);
        })
    }

    normalizeQuantity = num => num||((num==0)?0:undefined)

    render() {
        const sets = () =>{ 
        var data = this.props.data || this.state.data;
        return data.map((data, idx) => {
            return data&&<SetCard onClick={this.props.onChildClick&&this.props.onChildClick(data.ID)} key={idx} id={data.ID} url={data.ImageURL} color={data.Color} name={data.Name} quantityOwned={data.Quantity} quantityBuilt={data.QuantityBuilt} quantityOnWishlist={data.WantsQuantity}/>
        });
    }
        return (
            <InfiniteScroll
            dataLength={this.props.data||this.state.data.length} 
            next={this.props.data?()=>{}:this.fetchSets.bind(this)}
            hasMore={!this.props.data&&this.state.loading}
            loader={<h4>Loading...</h4>}
            endMessage={
                <p style={{ textAlign: 'center' }}>
                <b>Yay! You have seen it all</b>
                </p>
            }>
            <div className={styles.flex}>
                {sets()}
            </div>
            </InfiniteScroll>
        )
    }
}
