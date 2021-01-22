import styles from '../css/Loginpage.module.css'
import React, { Component } from 'react'
import {TextField, Link, Grid, Button, Typography, CssBaseline, Container} from '@material-ui/core'

export default class LoginPage extends Component {
    constructor(props){
        super(props);
        this.state = {
            email: "",
            password: ""
        }
    }
    
    render() {
        return (
            <Container component="main" maxWidth="xs">
            <CssBaseline />
            <div className={styles.paper}>
                <Typography component="h1" variant="h5">
                    Login
                </Typography>
                <TextField
                    variant="outlined"
                    margin="normal"
                    required
                    fullWidth
                    id="email"
                    label="Email Address"
                    name="email"
                    autoComplete="email"
                    autoFocus
                />
                <TextField
                    variant="outlined"
                    margin="normal"
                    required
                    fullWidth
                    name="password"
                    label="Password"
                    type="password"
                    id="password"
                    autoComplete="current-password"
                />
                <div className={styles.submitContainer}>
                    <Button
                        type="submit"
                        fullWidth
                        variant="contained"
                        color="primary"
                        className={styles.submit}
                    >
                        Login
                    </Button>
                </div>
                <Grid container>
                    <Grid item xs>
                    <Link href="#" variant="body2">
                        Forgot password?
                    </Link>
                    </Grid>
                    <Grid item xs>
                    <Link href="/signup" variant="body2">
                        Sign up
                    </Link>
                    </Grid>
                </Grid>
            </div>
            </Container>
        )
    }
}
