import styles from '../../css/Collection.module.css'
import React, { Component } from 'react'
import {BrickCard} from '../cards'
import InfiniteScroll from 'react-infinite-scroll-component'
import axios from 'axios'
import PropTypes from 'prop-types'

export default class BrickCollection extends Component {
    // static propTypes = {
    //     data: PropTypes.array,
    //     onChildClick: PropTypes.func
    // }
    constructor(props){
        super(props);
        this.state = {
            data: [],
            page: 1
        }
    }   
    
    componentDidMount(){
        this.fetchBricks();
    }

    normalizeQuantity = num => num||((num==0)?0:undefined)
    fetchBricks() {
        axios.get(process.env.REACT_APP_API_ENDPOINT+`/api/bricks/${this.state.page}/50`)
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
    render() {
        const bricks = () =>{ 
        var data = this.props.data || this.state.data;
        return data.map((data, idx) => {
            return <BrickCard onClick={this.props.onChildClick&&this.props.onChildClick(data.ID)} key={idx} id={data.ID} url={data.ImageURL} color={data.Color} name={data.Name} quantity={this.normalizeQuantity(data.Quantity)} quantityInUse={this.normalizeQuantity(data.QuantityInUse)} />
        });
        }
        return (
            <InfiniteScroll
            dataLength={this.props.data||this.state.data.length} 
            next={this.props.data?()=>{}:this.fetchBricks.bind(this)}
            hasMore={!this.props.data}
            loader={<h4>Loading...</h4>}
            endMessage={
                <p style={{ textAlign: 'center' }}>
                <b>Yay! You have seen it all</b>
                </p>
            }>
            <div className={styles.flex}>
                {bricks()}
            </div>
            </InfiniteScroll>
        )
    }
}
