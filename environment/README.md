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

| Week        | Library        |
|-------------|----------------|
| *2 (24-05)* | psycopg2       |
| *4 (14-06)* | pymongo        |
|             | requests       |
|             | beautifulsoup4 |
| *6 (28-06)* | pyspark <a href="#note1" id="note1ref"><sup>1</sup></a>        |
|             | pandas         |

### Install libraries

The _requirements.txt_ contains Python libraries to install.

If you are a Pure-Python <a id="note2" href="#note2ref"><sup>2</sup></a> user do:

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

_Notes_:

<a id="note1" href="#note1ref"><sup>1</sup></a> Pyspark requires Java 8.

<a id="note2" href="#note2ref"><sup>2</sup></a> For the sake of simplicity, Pure-Python users need to install `psycopg2-binary` and not `psycopg2`.

