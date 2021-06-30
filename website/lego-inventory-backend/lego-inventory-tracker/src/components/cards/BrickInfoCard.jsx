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
        import image from "../../static/legoBricks.jpg"
        import Button from '@material-ui/core/Button';
import CardActions from '@material-ui/core/CardActions';
        
export default class BickInfoCard extends Component {
    
    render() {
        return (
          <Card className={styles.root}>
          <CardActionArea component={Link} to='/bricks'>
            <CardMedia
              className={styles.media}
              component='img'
              image={image}
              title="Bricks"
            />
            <CardContent>
              <Typography gutterBottom variant="h5" component="h2">
                Lego Bricks
              </Typography>
              <Typography variant="body2" color="textSecondary" component="p">
                Search through our database of tens of thousands of lego sets based on name, ID, or color.
                You can also see what bricks are needed to build any given set based on your current inventory.
              </Typography>
            </CardContent>
          </CardActionArea>
          <CardActions>
            <Button size="large" color="primary" component={Link} to='/bricks'>
              GO TO BRICKS
            </Button>
            
          </CardActions>
        </Card>
        )
    }
}
