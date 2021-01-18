import styles from '../css/Homepage.module.css'
import React, { Component } from 'react'
import {AppBar, Toolbar,  IconButton, Typography, Button} from '@material-ui/core'
import MenuIcon from '@material-ui/icons/Menu'

export default class Homepage extends Component {
    render() {
        return (
            <div id="nav" className={styles.flexGrow} >
                <AppBar position="static">
                <Toolbar>
                    <IconButton edge="start" className={styles.menuButton} color="inherit" aria-label="menu">
                    <MenuIcon />
                    </IconButton>
                    <Typography variant="h6" className={styles.flexGrow}>
                    Lego Inventory Tracker
                    </Typography>
                    <Button color="inherit">Login / Sign Up</Button>
                </Toolbar>
                </AppBar>
            </div>
        )
    }
}
