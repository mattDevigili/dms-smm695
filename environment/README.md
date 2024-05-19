# Environment

Here, you can find info on python libraries for _Data Management Systems_.

## Create a Python/Conda Environment

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

## Libraries

This is a list of python libraries you need to install:

| Week      | Library        |
| --------- | -------------- |
| 2 (31-05) | psycopg2       |
|           | sqlalchemy     |
|           | pandas         |
| 4 (13-06) | pymongo        |
|           | requests       |
|           | beautifulsoup4 |
| 6 (28-06) | pyspark        |
|           |                |

### Install libraries

The [requirements.txt](https://github.com/mattDevigili/dms-smm695/blob/master/environment/requirements.txt) contains Python libraries to install.

If you are a Pure-Python user do:

```{python}
pip install -r requirements.txt
```

If you are a Conda user do:

```{python}
conda install --file requirements.txt
```
