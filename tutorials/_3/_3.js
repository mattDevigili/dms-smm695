/*
Tutorial _3: MongoDB and Left Joins with $lookup

The 3 CSVs contain a micro sample of IMDb data:

 * akas_micro, 97 documents
 * basics_micro, 10 documents
 * ratings_micro, 10 documents

Topics:
0. Set up
1. $lookup
*/

// ###################
// #### 0. SET UP ####
// ###################

// Let's insert the data, type on your terminal:

mongoimport --db=imdb --collection=akas --type=csv --headerline --file=akas_micro.csv
mongoimport --db=imdb --collection=basics --type=csv --headerline --file=basics_micro.csv
mongoimport --db=imdb --collection=ratings --type=csv --headerline --file=ratings_micro.csv

// Let's inspect what we have

use imdb;

show collections;

/*
 akas
 basics
 ratings
 */

db.akas.find().pretty().limit(1);

/*
 {
	"_id" : ObjectId("60d4e6775d27f1d418e9fc14"),
	"titleid" : "tt0000001",
	"ordering" : 8,
	"title" : "カルメンチータ",
	"region" : "JP",
	"language" : "ja",
	"types" : "imdbDisplay",
	"attributes" : "\\N",
	"isoriginaltitle" : 0
}
*/

db.basics.find().pretty().limit(1);

/*
 {
	"_id" : ObjectId("60d4e6c35da76c97e5fbe654"),
	"tconst" : "tt0000002",
	"titletype" : "short",
	"primarytitle" : "Le clown et ses chiens",
	"originaltitle" : "Le clown et ses chiens",
	"isadult" : 0,
	"startyear" : 1892,
	"endyear" : "\\N",
	"runtimeminutes" : 5,
	"genres" : "Animation,Short"
}
*/

db.ratings.find().pretty().limit(1);

/*
 {
	"_id" : ObjectId("60d4e6ca1367b1a57490f75b"),
	"tconst" : "tt0000002",
	"averagerating" : 6.1,
	"numvotes" : 210
}
*/

// ####################
// #### 1. $lookup ####
// ####################


/*
  $lookup

  "Performs a left outer join to an unsharded collection in the same database to
  filter in documents from the "joined" collection for processing. To each
  input document, the $lookup stage adds a new array field whose elements are
  the matching documents from the "joined" collection. The $lookup stage passes
  these reshaped documents to the next stage" (MongoDB docs).

  {
   $lookup:
     {
       from: <collection to join>,
       localField: <field from the input documents>,
       foreignField: <field from the documents of the "from" collection>,
       as: <output array field>
     }
}

   MongoDB Docs: https://docs.mongodb.com/manual/reference/operator/aggregation/lookup/
    */

// Let's create the joining stage between basics and ratings

var join0 = {$lookup:
    {
        from: "ratings",
        localField: "tconst",
        foreignField: "tconst",
        as: "ratings_array"
    }
}

// For exploratory purposes let's create a limit stage
var limit = {$limit: 1}

// Let's run the aggregation:

db.basics.aggregate([join0, limit]).pretty();

/* A new field named "ratings_array" is added:
 
 {
	"_id" : ObjectId("60d4e6c35da76c97e5fbe654"),
	"tconst" : "tt0000002",
	"titletype" : "short",
	"primarytitle" : "Le clown et ses chiens",
	"originaltitle" : "Le clown et ses chiens",
	"isadult" : 0,
	"startyear" : 1892,
	"endyear" : "\\N",
	"runtimeminutes" : 5,
	"genres" : "Animation,Short",
	"ratings_array" : [
		{
			"_id" : ObjectId("60d4e6ca1367b1a57490f75b"),
			"tconst" : "tt0000002",
			"averagerating" : 6.1,
			"numvotes" : 210
		}
	]
}
*/


// Let's join akas and basics

var join1 = {$lookup:
    {
        from: "akas",
        localField: "tconst",
        foreignField: "titleid",
        as: "akas_array"
    }
}


db.basics.aggregate([join1, limit]).pretty();

/* A new field "akas_array" is added:
 
{
	"_id" : ObjectId("60d4e6c35da76c97e5fbe654"),
	"tconst" : "tt0000002",
	"titletype" : "short",
	"primarytitle" : "Le clown et ses chiens",
	"originaltitle" : "Le clown et ses chiens",
	"isadult" : 0,
	"startyear" : 1892,
	"endyear" : "\\N",
	"runtimeminutes" : 5,
	"genres" : "Animation,Short",
	"akas_array" : [
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc1b"),
			"titleid" : "tt0000002",
			"ordering" : 4,
			"title" : "Der Clown und seine Hunde",
			"region" : "DE",
			"language" : "\\N",
			"types" : "\\N",
			"attributes" : "literal title",
			"isoriginaltitle" : 0
		},
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc1d"),
			"titleid" : "tt0000002",
			"ordering" : 7,
			"title" : "The Clown and His Dogs",
			"region" : "US",
			"language" : "\\N",
			"types" : "\\N",
			"attributes" : "literal English title",
			"isoriginaltitle" : 0
		},
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc1e"),
			"titleid" : "tt0000002",
			"ordering" : 1,
			"title" : "Le clown et ses chiens",
			"region" : "\\N",
			"language" : "\\N",
			"types" : "original",
			"attributes" : "\\N",
			"isoriginaltitle" : 1
		},
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc1f"),
			"titleid" : "tt0000002",
			"ordering" : 3,
			"title" : "Le clown et ses chiens",
			"region" : "FR",
			"language" : "\\N",
			"types" : "\\N",
			"attributes" : "\\N",
			"isoriginaltitle" : 0
		},
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc20"),
			"titleid" : "tt0000002",
			"ordering" : 8,
			"title" : "道化師と犬",
			"region" : "JP",
			"language" : "ja",
			"types" : "imdbDisplay",
			"attributes" : "\\N",
			"isoriginaltitle" : 0
		},
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc21"),
			"titleid" : "tt0000002",
			"ordering" : 5,
			"title" : "Clovnul si cainii sai",
			"region" : "RO",
			"language" : "\\N",
			"types" : "imdbDisplay",
			"attributes" : "\\N",
			"isoriginaltitle" : 0
		},
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc24"),
			"titleid" : "tt0000002",
			"ordering" : 2,
			"title" : "A bohóc és kutyái",
			"region" : "HU",
			"language" : "\\N",
			"types" : "imdbDisplay",
			"attributes" : "\\N",
			"isoriginaltitle" : 0
		},
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc25"),
			"titleid" : "tt0000002",
			"ordering" : 6,
			"title" : "Клоун и его собаки",
			"region" : "RU",
			"language" : "\\N",
			"types" : "imdbDisplay",
			"attributes" : "\\N",
			"isoriginaltitle" : 0
		}
	]
}
*/

// Let's now join all the collections:

db.basics.aggregate([join0, join1, limit]).pretty();

/* Two new fields "ratings_array" and "akas_array" are added:
 
 {
	"_id" : ObjectId("60d4e6c35da76c97e5fbe654"),
	"tconst" : "tt0000002",
	"titletype" : "short",
	"primarytitle" : "Le clown et ses chiens",
	"originaltitle" : "Le clown et ses chiens",
	"isadult" : 0,
	"startyear" : 1892,
	"endyear" : "\\N",
	"runtimeminutes" : 5,
	"genres" : "Animation,Short",
	"ratings_array" : [
		{
			"_id" : ObjectId("60d4e6ca1367b1a57490f75b"),
			"tconst" : "tt0000002",
			"averagerating" : 6.1,
			"numvotes" : 210
		}
	],
	"akas_array" : [
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc1b"),
			"titleid" : "tt0000002",
			"ordering" : 4,
			"title" : "Der Clown und seine Hunde",
			"region" : "DE",
			"language" : "\\N",
			"types" : "\\N",
			"attributes" : "literal title",
			"isoriginaltitle" : 0
		},
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc1d"),
			"titleid" : "tt0000002",
			"ordering" : 7,
			"title" : "The Clown and His Dogs",
			"region" : "US",
			"language" : "\\N",
			"types" : "\\N",
			"attributes" : "literal English title",
			"isoriginaltitle" : 0
		},
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc1e"),
			"titleid" : "tt0000002",
			"ordering" : 1,
			"title" : "Le clown et ses chiens",
			"region" : "\\N",
			"language" : "\\N",
			"types" : "original",
			"attributes" : "\\N",
			"isoriginaltitle" : 1
		},
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc1f"),
			"titleid" : "tt0000002",
			"ordering" : 3,
			"title" : "Le clown et ses chiens",
			"region" : "FR",
			"language" : "\\N",
			"types" : "\\N",
			"attributes" : "\\N",
			"isoriginaltitle" : 0
		},
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc20"),
			"titleid" : "tt0000002",
			"ordering" : 8,
			"title" : "道化師と犬",
			"region" : "JP",
			"language" : "ja",
			"types" : "imdbDisplay",
			"attributes" : "\\N",
			"isoriginaltitle" : 0
		},
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc21"),
			"titleid" : "tt0000002",
			"ordering" : 5,
			"title" : "Clovnul si cainii sai",
			"region" : "RO",
			"language" : "\\N",
			"types" : "imdbDisplay",
			"attributes" : "\\N",
			"isoriginaltitle" : 0
		},
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc24"),
			"titleid" : "tt0000002",
			"ordering" : 2,
			"title" : "A bohóc és kutyái",
			"region" : "HU",
			"language" : "\\N",
			"types" : "imdbDisplay",
			"attributes" : "\\N",
			"isoriginaltitle" : 0
		},
		{
			"_id" : ObjectId("60d4e6775d27f1d418e9fc25"),
			"titleid" : "tt0000002",
			"ordering" : 6,
			"title" : "Клоун и его собаки",
			"region" : "RU",
			"language" : "\\N",
			"types" : "imdbDisplay",
			"attributes" : "\\N",
			"isoriginaltitle" : 0
		}
	]
}
*/