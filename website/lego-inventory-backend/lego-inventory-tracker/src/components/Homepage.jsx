import styles from '../css/Homepage.module.css'
import React, { Component } from 'react'
import SetInfoCard from './cards/SetInfoCard'
import BrickInfoCard from './cards/BrickInfoCard'
import DocInfoCard from './cards/DocInfoCard'
import TestCard from './cards/TestCard' 


export default class Homepage extends Component {
    render() {
        return (
            <>
            <div className={styles.header}>
                <h1>Welcome to the Lego Inventory Tracker!</h1>
                <p>Created by: Luke Ferderer, Jamari Morisson, and Jason Cramer</p>
            </div>
            <div className={styles.cardContainer}>
            <SetInfoCard/>
            <BrickInfoCard/>
            <DocInfoCard/>
            </div>
           
            </>
        )
    }
}
