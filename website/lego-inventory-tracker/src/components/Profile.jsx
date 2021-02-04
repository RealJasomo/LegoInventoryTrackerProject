import React, { Component } from 'react'
import {FormControl, InputLabel, OutlinedInput, InputAdornment, IconButton, Button, Modal} from '@material-ui/core'
import { connect } from 'react-redux'
import { setToken } from '../store/actions/actions'
import axios from 'axios'

import Visibility from '@material-ui/icons/Visibility'
import VisibilityOff from '@material-ui/icons/VisibilityOff'
import styles from '../css/Profile.module.css'

class Profile extends Component {
    constructor(props){
        super(props);
        this.state ={
            newPassword: '',
            oldPassword: '',
            confirmPassword: '',
            showOldPassword: false,
            showNewPassword: false,
            showConfirmPassword: false,
            error: '',
            openPassword: false,
            openDelete: false
        }
    }
    
    handleChange = (prop) => async (event) => {
        await this.setState({[prop]: event.target.value});
        if(this.state.newPassword !== this.state.confirmPassword)
            this.setState({error: "The passwords don't match"})
        else
            this.setState({error: ""})
    };
    
    handlePasswordModalClose = () => this.setState({openPassword: false});
    
    handleDeleteModalClose = () => this.setState({openDelete: false});

    handleClickShowPassword = (prop) => {
       this.setState({ [prop]: !this.state[prop] });
    };

    handleMouseDownPassword = (event) => {
        event.preventDefault();
    };
    
    handleUpdatePassword = () =>{
        if(this.state.error=='')
            axios({
                method: 'PUT',
                url:`${process.env.REACT_APP_API_ENDPOINT}/api/users/updatePassword`,
                headers: {
                    "Authorization": `Bearer ${this.props.auth.token}`,
                    "Content-Type": "application/json"
                },
                data: {
                    newPassword: this.state.newPassword,
                    oldPassword: this.state.oldPassword
                }
            }).then((res) => {
                this.handlePasswordModalClose();
            }).catch((err) => {
                this.setState({error: "Ther was an error updating your credentials"})
                this.handlePasswordModalClose();
            })
    }
    handleDeleteAccount = () => {
        axios({
            method: 'DELETE',
            url:`${process.env.REACT_APP_API_ENDPOINT}/api/users/delete`,
            headers: {
                "Authorization": `Bearer ${this.props.auth.token}`,
            }
        }).then((res) => {
            this.props.setToken("");
            window.location.href="/";
        }).catch((err) => {
            this.setState({error: "Ther was an error updating your credentials"})
            this.handleDeleteModalClose();
        })
    }
    
    render() {
        return (
            <>
             <Modal aria-labelledby="modal-title"
                open={this.state.openPassword}
                onClose={this.handlePasswordModalClose}>
                <div className={styles.paper}>
                    <h1 id="modal-title">Are you sure you want to change your password?</h1>
                    <p>Warning: this action can not be undone</p>
                    <div className={styles.modalButtons}>
                        <Button variant="contained" color="secondary" className={styles.marginRight} onClick={this.handlePasswordModalClose}>close</Button>
                        <Button variant="contained" color="primary" onClick={this.handleUpdatePassword}>confirm</Button>
                    </div>
                </div>
            </Modal>
            <Modal aria-labelledby="modal-title"
                open={this.state.openDelete}
                onClose={this.handleDeleteModalClose}>
                <div className={styles.paper}>
                    <h1 id="modal-title">Are you sure you want to delete your account?</h1>
                    <p>Warning: this action can not be undone. All user data will be deleted</p>
                    <div className={styles.modalButtons}>
                        <Button variant="contained" color="secondary" className={styles.marginRight} onClick={this.handleDeleteModalClose} >close</Button>
                        <Button variant="contained" color="primary" onClick={this.handleDeleteAccount}>confirm</Button>
                    </div>
                </div>
            </Modal>
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
                <Button className={styles.update} variant="contained" color="primary" onClick={()=>this.setState({openPassword: true})}>
                Update your password
                </Button>
            </div>
            <hr/>
            <div className={styles.flex}>
                <h2 className={styles.delete}>Delete your account:</h2>
                <Button className={styles.delete} variant="contained" color="secondary" onClick={()=>this.setState({openDelete: true})}>
                Delete your account
                </Button>
            </div>
            </>
        )
    }
}
const mapState = state => ({
    auth: state.authToken
})
export default connect(mapState, {setToken})(Profile);