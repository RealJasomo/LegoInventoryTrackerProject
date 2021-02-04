import styles from '../../css/Cards.module.css'
import React, { Component } from 'react'
import PropTypes from 'prop-types'
import {Card, 
        CardActionArea, 
        CardContent,
        CardMedia,
        Typography} from '@material-ui/core'

export default class ModelCard extends Component {
    static propTypes = {
        id: PropTypes.string,
        url: PropTypes.string,
        name: PropTypes.string
    }
    render() {
        return (
            <Card className={styles.root}>
            <CardActionArea>
              <CardMedia
                className={styles.media}
                image={this.props.url}
                title={this.props.name}
              />
              <CardContent>
                <Typography gutterBottom variant="h5" component="h2">
                  Model {this.props.id}
                </Typography>
                <Typography variant="body2" color="textSecondary" component="p">
                  Name: {this.props.name}
                </Typography>
              </CardContent>
            </CardActionArea>
          </Card>
        )
    }
}
