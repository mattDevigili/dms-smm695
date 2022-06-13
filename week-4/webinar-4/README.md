# Webinar Structure
Here you can find the structure for the fourth webinar. 

| **Week (date)** | **Agenda**                                           |
|-----------------|------------------------------------------------------|
| 4 (14-06)       | [AWS RDS](https://aws.amazon.com/rds/)               |
|                 | _Q&A_                                                |
|                 | Mongo Shell, Compass, Atlas                          |
|                 | Homework 4 solutions                                 |
|                 | [PyMongo](https://pymongo.readthedocs.io/en/stable/) |
|                 | - Basic Interaction                                  |
|                 | - Scraping & storing                                 |

Follow the [instructions](https://aws.amazon.com/getting-started/tutorials/create-connect-postgresql-db/) to 'create and connect to a PostgreSQL' database instance using 
[Amazon Relational Database Service](https://aws.amazon.com/rds/).

# Python set-up

Check the [environment](https://github.com/mattDevigili/dms-smm695/tree/master/environment) folder.

## Create a Python Environment

If you are a Pure-Python user do:

```bash
python -m venv my_env
```
Check [venv](https://docs.python.org/3/library/venv.html) for further reference. 

If you are Conda user do:

```bash
conda create -n my_env python=3.x
```
Check [conda create](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#creating-an-environment-with-commands) for further reference.

## Install libraries

The [requirements.txt](https://github.com/mattDevigili/dms-smm695/blob/master/environment/requirements.txt) contains Python libraries to install.

If you are a Pure-Python user do:

```bash
pip install -r requirements.txt
```

If you are a Conda user do:

```bash
conda install --file requirements.txt
```