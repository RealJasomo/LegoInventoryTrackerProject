import styles from '../../css/Collection.module.css'
import React, { Component } from 'react'
import {ModelCard} from '../cards'

export default class ModelCollection extends Component {
    render() {
        return (
            <div className={styles.flex}>
                <ModelCard id="3005" url="https://img.bricklink.com/ItemImage/PN/11/3005.png" name="1 x 1"/>
                <ModelCard id="3003" url="https://img.bricklink.com/ItemImage/PN/7/3003.png" name="2 x 2"/>
            </div>
        )
    }
}
