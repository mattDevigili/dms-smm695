# Final course project

<img src='https://upload.wikimedia.org/wikipedia/commons/6/69/Airbnb_Logo_Bélo.svg' width=100>

For the final course project (fcp), you will handle a real-world dataset. In
particular, you are required to collect, store, manipulate, and analyze
Airbnb data. This data are publicly available via [Inside Airbnb](http://insideairbnb.com/about.html).

## Data

The data are available via Inside
Airbnb under the "[get the data](http://insideairbnb.com/get-the-data.html)" 
section, where you have to collect the latest available
data for _London_. Hence, you must use the following CSVs<a href="#note1" id="note1ref"><sup>1</sup></a>:


| data            | content                |
|-----------------|------------------------|
| listings.csv.gz | Detailed Listings      |
| calendar.csv.gz | Detailed Calendar Data |
| reviews.csv.gz  | Detailed Review Data   |


## Tasks

You are required to choose your preferred DBMS -- PostgreSQL or MongoDB -- and:

1. Clean, manipulate, and structure data. The expected result is a well-designed dataset that
   complies with the specific approach of the chosen DBMS. 
2. Provide valuable descriptive insights. The expected result is a set of descriptive statistics that
   depicts some interesting trends or noteworthy data characteristics.
3. _[optional]_ Perform an insightful data analysis. For example, you can use the available features
   to classify the offerings or predict their value. You may want to skim through the reference 
   list provided to get some inspiration.

To perform task 1 and 2, you need to use either `SQL` or `MQL`<a href="#note2" id="note2ref"><sup>2</sup></a> (MongoDB query language). 
Alternatively, if you prefer using python, you can leverage `psycopg2` or `pymongo`.
For what concerns task 3, you should use `PySpark` (e.g., you may want to leverage on the
[MLlib](https://spark.apache.org/docs/latest/api/python/reference/pyspark.ml.html) pyspark library).

## Deliverables

By July 16th (8:00 PM, London time), groups have to upload:

* SQL, JS, or Python scripts;
* Supporting documentation (accepted format: .md, .docx, or .pdf) containing:
  * a detailed justification of your design choices;
  * a clear and concise description of the insights coming from descriptive
      statistics obtained;
  * _[optional]_ a clear and concise description of further insights and results obtained 
      analyzing data through PySpark. 

## References

Here you can find some academic articles dealing with Airbnb:

* Barron, K., Kung, E., & Proserpio, D. (2021). The effect of home-sharing on house prices and rents: Evidence from Airbnb. _Marketing Science_, 40(1), 23-47. [[link](https://pubsonline.informs.org/doi/pdf/10.1287/mksc.2020.1227?casa_token=NOXeKdG2b0EAAAAA:2JXhlKCcI_hhQ8t2LWmoyBmeblVO3jrvQLAyzaJCrjSarw4I9lc5J6i-rPzQXNGkigDF8Vb0FQ)]
* Sun, S., Zhang, S., & Wang, X. (2021). Characteristics and influencing factors of Airbnb spatial distribution in China’s rapid urbanization process: A case study of Nanjing. _PloS one_, 16 (3). [[link](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0248647)]
* Chang, H. H., & Sokol, D. D. (2020). How incumbents respond to competition from innovative disruptors in the sharing economy — The impact of Airbnb on hotel performance. _Strategic Management Journal_. [[link](https://onlinelibrary.wiley.com/doi/abs/10.1002/smj.3201)]
* Boon, W. P., Spruit, K., & Frenken, K. (2019). Collective institutional work: the case of Airbnb in Amsterdam, London and New York. _Industry and Innovation_, 26 (8), 898-919. [[link](https://www.tandfonline.com/doi/pdf/10.1080/13662716.2019.1633279)]
* Deboosere, R., Kerrigan, D. J., Wachsmuth, D., & El-Geneidy, A. (2019). Location, location and professionalization: a multilevel hedonic analysis of Airbnb listing prices and revenue. _Regional Studies, Regional Science_, 6 (1), 143-156. [[link](https://www.tandfonline.com/doi/pdf/10.1080/21681376.2019.1592699)]
* Ye, P. , Qian, J., Chen, J., Wu, C., Zhou, Y., De Mars, S.,  Yang, F. and Zhang, L. (2018). Customized Regression Model for Airbnb Dynamic Pricing. In _Proceedings of the 24th ACM SIGKDD International Conference on Knowledge Discovery & Data Mining_ (KDD '18). Association for Computing Machinery, New York, NY, USA, 932–940. [[link](https://dl.acm.org/doi/pdf/10.1145/3219819.3219830)]
* Abrahao, B., Parigi, P., Gupta, A., & Cook, K. S. (2017). Reputation offsets trust judgments based on social biases among Airbnb users. _Proceedings of the National Academy of Sciences_, 114 (37), 9848-9853. [[link](https://www.pnas.org/content/114/37/9848.full)]

Here you can find some further readings:

* Lee, Dave (2021). Airbnb claims ‘resilience’ as bookings begin to bounce back. _Financial Times_, Feb. 25. [[link](https://www.ft.com/content/a64fe523-4415-4002-8f1d-7ae95c352fb0)]
* The Economist (2020). Airbnb guests seek out cleaner properties in the pandemic. _The Economist_, Dec. 8. [[link](https://www.economist.com/graphic-detail/2020/12/08/airbnb-guests-seek-out-cleaner-properties-in-the-pandemic)]
* Glusac, Elaine (2020). Hotels vs Airbnb: Has Covid-19 Disrupted the Disrupter? _The New York Times_, Nov. 16. [[link](https://www.nytimes.com/2020/05/14/travel/hotels-versus-airbnb-pandemic.html)]

------------------------------------------------------------------------------------------------------------------------
    
### Notes

<a id="note1" href="#note1ref">1</a>: You can find further information on data structure [here](https://docs.google.com/spreadsheets/d/1iWCNJcSutYqpULSQHlNyGInUvHg2BoUGoNRIGa6Szc4/edit#gid=982310896).

<a id="note2" href="#note2ref">2</a>: Choosing MongoDB, you may be interested in `$lookup`; see further info [here](https://docs.mongodb.com/manual/reference/operator/aggregation/lookup/). 