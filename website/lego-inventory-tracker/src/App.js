import styles from "./css/App.module.css"
import React, { Component } from 'react'
import {
  BrowserRouter as Router,
  Switch,
  Route
} from "react-router-dom";
import {Homepage, BrickCollection, ModelCollection, SetCollection} from './components'
import {AppBar, Toolbar,  IconButton, Typography, Button} from '@material-ui/core'
import MenuIcon from '@material-ui/icons/Menu'

export default class App extends Component {
  render() {
    return (
      <>
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
        <div id="app-container">
          <Router>
            <Switch>
              <Route exact path="/">
                <Homepage />
              </Route>
            </Switch>
            <Switch>
              <Route path="/sets">
                <SetCollection />
              </Route>
            </Switch>
            <Switch>
              <Route path="/models">
                <ModelCollection />
              </Route>
            </Switch>
            <Switch>
              <Route path="/bricks">
                <BrickCollection />
              </Route>
            </Switch>
          </Router>
        </div>
      </>
    )
  }
}

