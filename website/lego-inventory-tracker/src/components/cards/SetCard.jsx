import styles from '../../css/Cards.module.css'
import React, { Component } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import {Card, 
        CardActionArea, 
        CardContent,
        CardMedia,
        Typography} from '@material-ui/core'

export default class SetCard extends Component {
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
                  onClick={() => console.log(
                      axios.get(process.env.REACT_APP_API_ENDPOINT+`/api/set/${this.props.id}/includes`)
                      .then((res) => {
                          console.log(res.data.data);
                      })
                      .catch((err) => {
                          console.log(err);
                      })
                  )}
                />
                <CardContent>
                  <Typography gutterBottom variant="h5" component="h2">
                    {this.props.name}
                  </Typography>
                  <Typography variant="body2" color="textSecondary" component="p">
                    Set ID: {this.props.id}
                  </Typography>
                </CardContent>
              </CardActionArea>
            </Card>
        )
    }
}
