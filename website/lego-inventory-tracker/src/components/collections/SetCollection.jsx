import styles from '../../css/Collection.module.css'
import React, { Component } from 'react'
import {SetCard} from '../cards'
import axios from 'axios'
import PropTypes from 'prop-types'
import InfiniteScroll from 'react-infinite-scroll-component'


export default class SetCollection extends Component {
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
        this.fetchSets();
    }

    fetchSets() {
        axios.get(process.env.REACT_APP_API_ENDPOINT+`/api/sets/${this.state.page}/50`)
        .then((res) => {
            console.log(res.data.data);
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
        const sets = () =>{ 
        var data = this.props.data || this.state.data;
        return data.map((data, idx) => {
            return <SetCard key={idx} id={data.ID} url={data.ImageURL} color={data.Color} name={data.Name} />
        });
    }
        return (
            <InfiniteScroll
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
            </InfiniteScroll>
        )
    }
}
