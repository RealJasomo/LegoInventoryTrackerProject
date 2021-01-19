import styles from '../../css/BrickCollection.module.css'
import React, { Component } from 'react'
import {BrickCard} from '../cards'
export default class BrickCollection extends Component {
    render() {
        return (
            <div className={styles.flex}>
                <BrickCard id="3005" url="https://img.bricklink.com/ItemImage/PN/11/3005.png" color="black" name="1 x 1"/>
                <BrickCard id="3003" url="https://img.bricklink.com/ItemImage/PN/7/3003.png" color="blue" name="2 x 2"/>
            </div>
        )
    }
}
