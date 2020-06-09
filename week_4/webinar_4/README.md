# Webinar Structure
Here you can find the structure for the fourth webinar. 

| **Week (date)** | **Agenda**                                           |
|-----------------|------------------------------------------------------|
| 4 (11-06)       | [AWS RDS](https://aws.amazon.com/rds/)               |
|                 | _Q&A_                                                |
|                 | Mongo Shell, Compass, Atlas                         |
|                 | Homework 4 solutions                                 |
|                 | [PyMongo](https://pymongo.readthedocs.io/en/stable/) |
|                 | - Basic Interaction                                  |
|                 | - Scraping & storing                                 |
|                 | Load sample DBs on MongoDB Atlas                     |

Follow the [instructions](https://aws.amazon.com/getting-started/tutorials/create-connect-postgresql-db/) to 'create and connect to a PostgreSQL' database instance using 
[Amazon Relational Database Service](https://aws.amazon.com/rds/).

No preparation is required to attend this webinar.

# Create a Python Environment

If you are a Pure-Python user do:

```{python}
python -m venv create my_env
```
Check [venv](https://docs.python.org/3/library/venv.html) for further reference. 

If you are Conda user do:

```{python}
conda create -n my_env python=3.x
```
Check [conda create](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#creating-an-environment-with-commands) for further reference.

# Install libraries

The _requirements.txt_ contains Python libraries to install.

If you are a Pure-Python user do:

```{python}
pip install -r requirements.txt
```

If you are a Conda user do:

```{python}
conda install --file requirements.txt
```