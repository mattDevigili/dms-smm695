# Webinar Structure
Here you can find the structure for the second webinar. 

| **Week (date)** | **Agenda**                                       |
|-----------------|--------------------------------------------------|
| 2 (28-05)       | Introduction to Design Theory (part one)         |
|                 | _Q&A_                                            |
|                 | [Pagila](https://github.com/devrimgunduz/pagila) |
|                 | - SQL examples                                   |
|                 | - Introduction to functions                      |
|                 | [Psycopg2](https://www.psycopg.org/docs/)        |
|                 | - Basic usage                                    |
|                 | - Homework solutions                             |

No preparation is required to attend this webinar.

# Create a Python Environment

If you are a Pure-Python user do:

```{python}
python3 -m venv my_env
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


