import styles from "./css/App.module.css"
import { ReactComponent as BrickLogo } from "./res/brick.svg";
import React, { Component } from 'react'
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link
} from "react-router-dom";
import {Homepage, BrickCollection, ModelCollection, SetCollection} from './components'
import {AppBar, Toolbar,  IconButton, Typography, 
        Button, Drawer, List, ListItem, ListItemIcon, ListItemText, SvgIcon} from '@material-ui/core'
import MenuIcon from '@material-ui/icons/Menu'

export default class App extends Component {
  constructor(){
  super();
   this.state = {
    menuOpen: false
  }
}
  toggleDrawer = (isOpen) => () =>{
    this.setState({
      menuOpen: isOpen
    })
  }
  render() {
    return (
      <>
      <Router>
        <div id="nav" className={styles.flexGrow} >
                  <AppBar position="static">
                  <Toolbar>
                      <IconButton edge="start" className={styles.menuButton} onClick={this.toggleDrawer(true)}color="inherit" aria-label="menu">
                      <MenuIcon />
                      </IconButton>
                      <Typography variant="h6" className={`${styles.flexGrow} ${styles.link}`} component={Link} to='/'>
                      Lego Inventory Tracker
                      </Typography>
                      <Button color="inherit">Login / Sign Up</Button>
                  </Toolbar>
                  </AppBar>
                  <Drawer open={this.state.menuOpen} onClose={this.toggleDrawer(false)}>
                    <div
                      tabIndex={0}
                      role="button"
                      onClick={this.toggleDrawer(false)}
                      onKeyDown={this.toggleDrawer(false)}
                    >
                       <List>
                        {['Bricks', 'Models', 'Sets'].map((text, index, arr) => (
                          <Link to={`/${arr[index].toLowerCase()}`} className={styles.link}>
                            <ListItem button key={text}>
                              <ListItemIcon>
                                  <SvgIcon>
                                    <BrickLogo/>
                                  </SvgIcon>
                                </ListItemIcon>
                              <ListItemText primary={text} />
                            </ListItem>
                          </Link>
                        ))}
                      </List>
                    </div>
                  </Drawer>
        </div>
        <div id="app-container">
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
        </div>
        </Router>
      </>
    )
  }
}

