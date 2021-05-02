import styles from '../css/Loginpage.module.css'
import React, { Component } from 'react'
import {TextField, Button, Typography, CssBaseline, Container} from '@material-ui/core'
import axios from 'axios'
import { connect } from 'react-redux'
import { setToken } from '../store/actions/actions'

 class SignUpPage extends Component {
    constructor(props){
        super(props);
        this.state = {
            username: "",
            password: "",
            error:""
        }
    }
    handleSignup = (event) => {
        event.preventDefault();
        axios({
            method: 'POST',
            url:'/api/users/create',
            headers: {
                "Content-Type": "application/json"
            },
            data: {
                username: this.state.username,
                password: this.state.password
            }
        })
        .then((response) => {
            this.setState({
                ...this.state,
                error: ""
            })
            console.log(response);
            this.props.setToken(response.data.token);
        })
        .then((_) => window.location.href="/")
        .catch((err) => {
            console.log(err.response);
            this.setState({
                ...this.state,
                error: err.response.data.error
            });
        })
    }
    render() {
        let errorMessage;
        if(this.state.error){
            errorMessage = <div className={styles.warning}>{this.state.error}</div>;
        }
        return (
            <form onSubmit={this.handleSignup}>
            <Container component="main" maxWidth="xs">
            <CssBaseline />
            {errorMessage}
            <div className={styles.paper}>
                <Typography component="h1" variant="h5">
                    Sign Up
                </Typography>
                <TextField
                    variant="outlined"
                    margin="normal"
                    required
                    fullWidth
                    id="username"
                    label="Username"
                    name="username"
                    autoComplete="username"
                    autoFocus
                    onChange={e => this.setState({
                        ...this.state,
                        username: e.target.value
                    })}
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
                    onChange={e => this.setState({
                        ...this.state,
                        password: e.target.value
                    })}
                />
                <div className={styles.submitContainer}>
                    <Button
                        type="submit"
                        fullWidth
                        variant="contained"
                        color="primary"
                        className={styles.submit}
                    >
                        Sign Up
                    </Button>
                </div>
            </div>
            </Container>
            </form>
        )
    }
}
export default connect(null, {setToken})(SignUpPage);