import styles from '../css/Usercollection.module.css'
import React, { Component } from 'react'

export default class UserCollection extends Component {
    constructor(props){
        super(props);
    }
    
    render() {
        const CollectionComponent = this.props.component;
        return (
            <>
            <div id="favorites">
                    <h1 className={styles.marginLeft}>Favorites:</h1>
                    <CollectionComponent />
                </div>
                <div id="owned">
                    <h1 className={styles.marginLeft}>Collection:</h1>
                    <CollectionComponent />
            </div>
            </>
        )
    }
}
