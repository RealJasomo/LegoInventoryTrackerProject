import React, { Component } from 'react'
import {FormControl, InputLabel, OutlinedInput, InputAdornment, IconButton, Button} from '@material-ui/core'
import Visibility from '@material-ui/icons/Visibility';
import VisibilityOff from '@material-ui/icons/VisibilityOff';
import styles from '../css/Profile.module.css'
export default class Profile extends Component {
    constructor(props){
        super(props);
        this.state ={
            newPassword: '',
            oldPassword: '',
            confirmPassword: '',
            showOldPassword: false,
            showNewPassword: false,
            showConfirmPassword: false,
            error: ''
        }
    }
    handleChange = (prop) => async (event) => {
        await this.setState({[prop]: event.target.value});
        if(this.state.newPassword !== this.state.confirmPassword)
            this.setState({error: "The passwords don't match"})
        else
            this.setState({error: ""})
    };

    handleClickShowPassword = (prop) => {
       this.setState({ [prop]: !this.state[prop] });
    };

    handleMouseDownPassword = (event) => {
        event.preventDefault();
    };
    render() {
        return (
            <>
              <h1>Update your Profile:</h1>
              <div className={styles.flex}>
                <h2>Change password: </h2>
                <div>{this.state.error}</div>
                <FormControl className={styles.text} variant="outlined">
                    <InputLabel htmlFor="outlined-adornment-password">Old Password</InputLabel>
                    <OutlinedInput
                        id="outlined-adornment-password"
                        type={this.state.showOldPassword ? 'text' : 'password'}
                        value={this.state.oldPassword}
                        onChange={this.handleChange('oldPassword')}
                        endAdornment={
                        <InputAdornment position="end">
                            <IconButton
                            aria-label="toggle password visibility"
                            onClick={() => {this.handleClickShowPassword('showOldPassword')}}
                            onMouseDown={this.handleMouseDownPassword}
                            edge="end"
                            >
                            {this.state.showOldPassword ? <Visibility /> : <VisibilityOff />}
                            </IconButton>
                        </InputAdornment>
                        }
                        labelWidth={70}
                    />
                </FormControl>
                <FormControl className={styles.text}  variant="outlined">
                    <InputLabel htmlFor="outlined-adornment-password">New Password</InputLabel>
                    <OutlinedInput
                        id="outlined-adornment-password"
                        type={this.state.showNewPassword ? 'text' : 'password'}
                        value={this.state.newPassword}
                        onChange={this.handleChange('newPassword')}
                        endAdornment={
                        <InputAdornment position="end">
                            <IconButton
                            aria-label="toggle password visibility"
                            onClick={() => {this.handleClickShowPassword('showNewPassword')}}
                            onMouseDown={this.handleMouseDownPassword}
                            edge="end"
                            >
                            {this.state.showNewPassword ? <Visibility /> : <VisibilityOff />}
                            </IconButton>
                        </InputAdornment>
                        }
                        labelWidth={70}
                    />
                </FormControl>
                <FormControl className={styles.text}  variant="outlined">
                    <InputLabel htmlFor="outlined-adornment-password">Confirm Password</InputLabel>
                    <OutlinedInput
                        id="outlined-adornment-password"
                        type={this.state.showConfirmPassword ? 'text' : 'password'}
                        value={this.state.confirmPassword}
                        onChange={this.handleChange('confirmPassword')}
                        endAdornment={
                        <InputAdornment position="end">
                            <IconButton
                            aria-label="toggle password visibility"
                            onClick={() => {this.handleClickShowPassword('showConfirmPassword')}}
                            onMouseDown={this.handleMouseDownPassword}
                            edge="end"
                            >
                            {this.state.showConfirmPassword ? <Visibility /> : <VisibilityOff />}
                            </IconButton>
                        </InputAdornment>
                        }
                        labelWidth={70}
                    />
                </FormControl>
                <Button className={styles.update} variant="contained" color="primary">
                Update your password
                </Button>
            </div>
            <hr/>
            <div className={styles.flex}>
                <h2 className={styles.delete}>Delete your account:</h2>
                <Button className={styles.delete} variant="contained" color="secondary">
                Delete your account
                </Button>
            </div>
            </>
        )
    }
}
