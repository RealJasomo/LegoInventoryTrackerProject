import styles from '../../css/Collection.module.css'
import React, { Component } from 'react'
import {SetCard} from '../cards'

export default class SetCollection extends Component {
    render() {
        return (
            <div className={styles.flex}>
                <SetCard id="3005" url="https://img.bricklink.com/ItemImage/PN/11/3005.png" name="1 x 1"/>
                <SetCard id="3003" url="https://img.bricklink.com/ItemImage/PN/7/3003.png" name="2 x 2"/>
            </div>
        )
    }
}
