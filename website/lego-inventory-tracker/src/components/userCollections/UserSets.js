import styles from '../../css/Usercollection.module.css'

import React, { Component } from 'react'
import { SetCollection } from '..';

export default class UserSets extends Component {
    constructor(props){
        super(props);
    }
    
    render() {
        return (
            <>
                <div id="favoriteModels">
                    <h1 className={styles.marginLeft}>Favorites:</h1>
                    <SetCollection/>
                </div>
                <div id="ownedModels">
                    <h1 className={styles.marginLeft}>Collection:</h1>
                    <SetCollection/>
                </div>
            </>
        )
    }
}
