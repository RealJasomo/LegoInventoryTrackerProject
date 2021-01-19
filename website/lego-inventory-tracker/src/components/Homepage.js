import styles from '../css/Homepage.module.css'
import React, { Component } from 'react'


export default class Homepage extends Component {
    render() {
        return (
            <>
            <div className={styles.header}>
                <h1>Welcome to the Lego Inventory Tracker!</h1>
                <p>Created by: Luke Ferderer, Jamari Morisson, and Jason Cramer</p>
            </div>
            </>
        )
    }
}
