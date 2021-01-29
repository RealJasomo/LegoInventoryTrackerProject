import styles from '../../css/Collection.module.css'
import React, { Component } from 'react'
import {BrickCard} from '../cards'
import axios from 'axios'

export default class BrickCollection extends Component {
    constructor(props){
        super(props);
        this.state = {
            data: []
        }
    }   
    
    componentDidMount(){
        this.fetchBricks();
    }

    fetchBricks() {
        axios.get(process.env.REACT_APP_API_ENDPOINT+'/api/bricks')
        .then((res) => {
            console.log(res.data.data);
            this.setState({
                ...this.state,
                data: res.data.data
            })
        })
        .catch((err) => {
            console.log(err);
        })
    }

    render() {
        const bricks = this.state.data.map((data, idx) => {
            return <BrickCard key={idx} id={data.ID} url={data.ImageURL} color={data.Color} name={data.Name} />
        });
        return (
            <div className={styles.flex}>
                {bricks}
            </div>
        )
    }
}
