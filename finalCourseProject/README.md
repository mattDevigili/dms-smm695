# Final Course Project

For the final course project, you are required to handle a small size
collection of twitter data, gathered during the _3rd game of the 2018 NBA Finals_
between Cleveland Cavaliers and Golden State Warriors. Data are publicly
available at this
[link](https://www.kaggle.com/xvivancos/tweets-during-cavaliers-vs-warriors).
There, you can find a detailed description of data and the following files:

* _TweetsNBA.csv_: 51,425 observations, 44 columns (27.24 MB);
* _locations.csv_: 4,136 observations, 3 columns (122.64 KB);
* _TweetsNBA.json_: 51,425 observations, more than 100 fields (348.56 MB).

If you want to have further info on data structure and content check the 
[Tweet Data Dictionary](https://developer.twitter.com/en/docs/tweets/data-dictionary/overview/tweet-object).

**Note**: 
* You can ignore _locations.csv_ file;

## Task

Your task is to prepare data to be analyzed later by a senior data
scientist. In particular, you are required to (**A**) clean and structure raw
data, and (**B**) provide some useful insights. 

**A**: To perform data cleaning, structuring, and manipulation, you can use either
PostgreSQL or MongoDB. The expected result is a well-designed dataset that
complies with the specific approach of the two DBMS.

**B**: To provide useful insights, you can leverage either on SQL or MongoDB
query language. The expected result is a set of descriptive
statistics that depicts some interesting trends or noteworthy data characteristics.

The senior data scientist should be able to (i) clearly understand your strategy
for data handling, (ii) easily interact with the processed data, and (iii) get
some useful knowledge of the dataset. You can also provide additional analysis
with _PySpark_ (e.g. you may want to leverage on the
[MLlib](https://spark.apache.org/docs/latest/api/python/pyspark.mllib.html)
library). In so doing, you can also suggest future research directions
given the analysis provided.

## References

Working with NBA and Twitter data is not uncommon in management disciplines. You
may want to look at the following references:

* [Examining the “I” in team: A longitudinal investigation of the influence of 
  team narcissism composition on team outcomes in the NBA](https://journals.aom.org/doi/abs/10.5465/amj.2017.0218)
* [Who Loses When a Team Wins? Better Performance Increases Racial Bias](https://pubsonline.informs.org/doi/10.1287/orsc.2018.1232)
* [Using Retweets When Shaping Our Online Persona: Topic Modeling Approach](https://misq.org/using-retweets-when-shaping-our-online-persona-topic-modeling-approach.html)

## Deliverables

By July 17 (8:00 PM, London time), groups are required to upload:

* SQL/JS/Python scripts;
* Supporting documentation (accepted format: .md, .tex) containing:
  * a detailed justification of your design choices;
  * a clear and concise description of the insights coming from descriptive
      statistics obtained;
  * a clear and concise description of further insights and results obtained 
      analyzing data through PySpark (not mandatory). 
