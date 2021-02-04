import styles from '../../css/Collection.module.css'
import React, { Component } from 'react'
import {BrickCard} from '../cards'
import axios from 'axios'
import PropTypes from 'prop-types'

export default class BrickCollection extends Component {
    static propTypes = {
        data: PropTypes.array
    }
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
                data: res.data.data
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
            <div className={styles.flex}>
                {bricks()}
            </div>
        )
    }
}
