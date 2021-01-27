import styles from '../../css/Usercollection.module.css'

import React, { Component } from 'react'
import { ModelCollection } from '..';

export default class UserModels extends Component {
    constructor(props){
        super(props);
    }
    
    render() {
        return (
            <>
                <div id="favoriteModels">
                    <h1 className={styles.marginLeft}>Favorites:</h1>
                    <ModelCollection/>
                </div>
                <div id="ownedModels">
                    <h1 className={styles.marginLeft}>Collection:</h1>
                    <ModelCollection/>
                </div>
            </>
        )
    }
}
