import styles from '../../css/Collection.module.css'
import React, { Component } from 'react'
import {SetCard} from '../cards'
import axios from 'axios'
import PropTypes from 'prop-types'

export default class SetCollection extends Component {
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
        this.fetchSets();
    }

    fetchSets() {
        axios.get(process.env.REACT_APP_API_ENDPOINT+'/api/sets')
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
        const sets = () =>{ 
            var data = this.props.data || this.state.data;
            return data.map((data, idx) => {
                return <SetCard key={idx} id={data.ID} url={data.ImageURL} name={data.Name} />
            });
        }
            return (
                <div className={styles.flex}>
                    {sets()}
                </div>
            )
    }
}
