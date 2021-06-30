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
        import image from "../../static/docImage.png"
        import Button from '@material-ui/core/Button';
import CardActions from '@material-ui/core/CardActions';
        
export default class DocInfoCard extends Component {
    
    render() {
        return (
          <Card className={styles.root}>
          <CardActionArea>
            <CardMedia
              className={styles.media} 
              component='img'
              image={image}
              title="Documentation"
            />
            <CardContent>
              <Typography gutterBottom variant="h5" component="h2">
                Documentation
              </Typography>
              <Typography variant="body2" color="textSecondary" component="p">
                View documentation made for this project, including code, a security analysis, and a design report.
              </Typography>
            </CardContent>
          </CardActionArea>
          <CardActions>
            <Button size="large" color="primary" component={Link} to='/code'>
              CODE
            </Button>
            <Button size="large" color="primary" component={Link} to='/design-report'>
              DESIGN REPORT 
            </Button>
            <Button size="large" color="primary" component={Link} to='/sec-analysis'>
              SECURITY ANALYSIS
            </Button>
          </CardActions>
        </Card>
        )
    }
}
