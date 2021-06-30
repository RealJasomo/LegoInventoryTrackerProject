import styles from '../../css/InfoCards.module.css'
import React, { Component } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import {Link} from "react-router-dom";
import {Card, 
        CardActionArea, 
        CardContent,
        CardMedia,
        Typography} from '@material-ui/core'
        import image from "../../static/colosseumSet.png"
        import Button from '@material-ui/core/Button';
import CardActions from '@material-ui/core/CardActions';
        
export default class SetInfoCard extends Component {
    
    render() {
        return (
          <Card className={styles.root}>
          <CardActionArea component={Link} to='/sets'>
            <CardMedia
              className={styles.media}
              component='img'
              image={image}
              title="Colosseum"
            />
            <CardContent>
              <Typography gutterBottom variant="h5" component="h2">
                Lego Sets
              </Typography>
              <Typography variant="body2" color="textSecondary" component="p">
                Search through our database of tens of thousands of lego sets based on name or ID.
                This system can also show all sets that can be constructed from your current inventory.
              </Typography>
            </CardContent>
          </CardActionArea>
          <CardActions>
            <Button size="large" color="primary" component={Link} to='/bricks'>
              GO TO SETS
            </Button>
            
          </CardActions>
        </Card>
        )
    }
}
