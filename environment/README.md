# Environment

Here, you can find info on python libraries for _Data Management Systems_.

## Create a Python/Conda Environment

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

## Libraries

This is a list of python libraries you need to install:

| Week        | Library        |
|-------------|----------------|
| *2 (28-05)* | psycopg2       |
| *4 (11-06)* | pymongo        |
|             | requests       |
|             | beautifulsoup4 |
| *6 (25-06)* | pyspark [^1]        |
|             | pandas         |

### Install libraries

The _requirements.txt_ contains Python libraries to install.

If you are a Pure-Python [^2] user do:

```{python}
pip install -r requirements.txt
```

If you are a Conda user do:

```{python}
conda install --file requirements.txt
``` 

## Java 8

[Spark Documentation](https://spark.apache.org/docs/latest/):

> 'Spark runs on Java 8, Python 2.7+/3.4+ and R 3.1+. For the Scala API, Spark 2.4.5 uses Scala 2.12. 
> You will need to use a compatible Scala version (2.12.x)'.

To follow week 6, you need to run Java 8.

[^1]: Pyspark requires Java 8.
[^2]: For the sake of simplicity, Pure-Python users need to install `psycopg2-binary` and not `psycopg2`.

