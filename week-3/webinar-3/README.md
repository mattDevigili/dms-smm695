# Webinar Structure

Here you can find the structure for the third webinar. 

| **Week (date)** | **Agenda**                                                                                |
|-----------------|-------------------------------------------------------------------------------------------|
| 3 (07-06)       | Recap -- week 3                                                                           |
|                 | _Q&A_                                                                                     |
|                 | Introduction to Design Theory (part two)                                                  |
|                 | Homework solutions                                                                        |
|                 | [Artworks - Tate](https://github.com/tategallery/collection/blob/master/artwork_data.csv) |
|                 | --- FDs and Anomalies                                                                     |
|                 | --- Decomposition                                                                         |
|                 | --- Indexes and Views                                                                     |
|                 | [AWS RDS](https://aws.amazon.com/rds/)                                                    |

## Tate Data

<p align="center">
<img src="https://www.tate.org.uk/sites/default/files/styles/width-600/public/tanks_staircase_tate_modern_3_1.jpg" width="400">
</p>

[Tate Gallery](https://www.tate.org.uk) shared data on [artists](https://github.com/tategallery/collection/tree/master/artists) and [artworks](https://github.com/tategallery/collection/tree/master/artworks) up to Oct 2014. For this webinar, we are going to work with [artwork_data.csv](https://github.com/tategallery/collection/blob/master/artwork_data.csv).

You can obtain data via `wget`, type on your terminal:
 
```(python)
wget "https://github.com/tategallery/collection/blob/master/artwork_data.csv?raw=true"
```

_n.b._: wget need to be installed on your laptop.

## AWS

Follow the [instructions](https://aws.amazon.com/getting-started/tutorials/create-connect-postgresql-db/) to 'create and connect to a PostgreSQL' database instance using  [Amazon Relational Database Service](https://aws.amazon.com/rds/).