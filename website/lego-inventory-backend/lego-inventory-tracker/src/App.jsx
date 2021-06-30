import styles from "./css/App.module.css"
import { ReactComponent as BrickLogo } from "./res/brick.svg";
import React, { Component } from 'react'
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link,
  Redirect
} from "react-router-dom";
import {Homepage, LoginPage, BrickCollection, SetCollection, SignUpPage, UserCollection, Profile } from './components'
import {AppBar, Toolbar,  IconButton, Typography, 
        Button, Drawer, List, ListItem, ListItemIcon, ListItemText, SvgIcon} from '@material-ui/core'
import AccountCircleIcon from '@material-ui/icons/AccountCircle'
import MenuIcon from '@material-ui/icons/Menu'
import { setToken } from './store/actions/actions'
import {connect} from 'react-redux'

class App extends Component {
  constructor(props){
  super(props);
   this.state = {
    menuOpen: false
  }
}
  toggleDrawer = (isOpen) => () =>{
    this.setState({
      menuOpen: isOpen
    })
  }
  handleSignout = () => {
    this.props.setToken("");
  }
  render() {
    const loginButton = () => {
      if(this.props.auth.token)
        return <Button color="inherit" onClick={this.handleSignout}>Sign out</Button>
      else
        return<Button color="inherit" className={styles.link} component={Link} to='/login'>Login</Button> 
    }
    const sets = () => {
      if(this.props.auth.token)
        return <UserCollection component={SetCollection} type="sets"/>
      return <SetCollection />
    }
    const bricks = () => {
      if(this.props.auth.token)
        return <UserCollection component={BrickCollection} type="bricks"/>
      return <BrickCollection />
    }
    return (
      <>
      <Router>
        <div id="nav" className={styles.flexGrow} >
                  <AppBar position="static">
                  <Toolbar>
                      <IconButton edge="start" className={styles.menuButton} onClick={this.toggleDrawer(true)}color="inherit" aria-label="menu">
                      <MenuIcon />
                      </IconButton>
                      <div id="logo-text" className={styles.flexGrow}>
                        <Typography variant="h6" className={styles.link} component={Link} to='/'>
                        Lego Inventory Tracker
                        </Typography>
                      </div>
                    {loginButton()}             
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
                        {this.props.auth.token ? 
                          <Link to={`/profile`} className={styles.link}>
                            <ListItem button>
                              <AccountCircleIcon />
                              <ListItemText primary="&nbsp;&nbsp;&nbsp;Profile" />
                            </ListItem>
                          </Link>
                          :<></>}
                        {['Bricks', 'Sets'].map((text, index, arr) => (
                          <Link to={`/${arr[index].toLowerCase()}`} className={styles.link} key={text}>
                            <ListItem button>
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
                {sets()}
              </Route>
            </Switch>
            <Switch>
              <Route path="/bricks">
                {bricks()}
              </Route>
            </Switch>
            <Switch>
              <Route path="/login">
                <LoginPage/>
              </Route>
            </Switch>
            <Switch>
              <Route path="/signup">
                <SignUpPage />
              </Route>
            </Switch>
            <Switch>
              <Route path="/profile">
                {this.props.auth.token?<Profile />:<Redirect to={{pathname:'/'}}/>}
              </Route>
            </Switch>
            <Switch>
              <Route path="/sec-analysis"  component={() => { 
              window.location.href = 'https://github.com/RealJasomo/LegoInventoryTrackerProject/tree/production'; 
              return null;
              }}/>
            </Switch>
            <Switch>
              <Route path="/design-report"  component={() => { 
              window.location.href = 'https://github.com/RealJasomo/LegoInventoryTrackerProject/tree/production'; 
              return null;
              }}/>
            </Switch>
            <Switch>
              <Route path="/code"  component={() => { 
              window.location.href = 'https://github.com/RealJasomo/LegoInventoryTrackerProject/tree/production'; 
              return null;
              }}/>
            </Switch>
            
        </div>
        </Router>
      </>
    )
  }
}

const mapState = state => ({
    auth: state.authToken
})
export default connect(mapState, {setToken})(App);