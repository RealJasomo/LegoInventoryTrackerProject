import styles from '../../css/Cards.module.css'
import React, { Component } from 'react'
import PropTypes from 'prop-types'
import {Card, 
        CardActionArea, 
        CardContent} from '@material-ui/core'
import AddCircleIcon from '@material-ui/icons/AddCircle'
export default class AddCard extends Component {
    static propTypes = {
        id: PropTypes.string,
        url: PropTypes.string,
        color: PropTypes.string,
        name: PropTypes.string
    }
    render() {
        return (
            <Card className={styles.root}>
            <CardActionArea onClick={this.props.onClick}>
              <CardContent>
                <AddCircleIcon className={styles.icon} color="primary"/>
              </CardContent>
            </CardActionArea>
          </Card>
        )
    }
}
