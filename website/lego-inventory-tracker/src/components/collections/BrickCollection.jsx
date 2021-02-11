import styles from '../../css/Collection.module.css'
import React, { Component } from 'react'
import {BrickCard} from '../cards'
import InfiniteScroll from 'react-infinite-scroll-component'
import axios from 'axios'
import PropTypes from 'prop-types'

export default class BrickCollection extends Component {
    static propTypes = {
        data: PropTypes.array
    }
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
            return <BrickCard key={idx} id={data.ID} url={data.ImageURL} color={data.Color} name={data.Name} />
        });
        }
        return (
            <InfiniteScroll
            dataLength={this.props.data||this.state.data.length} 
            next={this.props.data?()=>{}:this.fetchBricks.bind(this)}
            hasMore={true}
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
