// 1. Loading data on our Atlas Cluster

// using mongoimport:
mongoimport --host **your***primary***cluster.mongodb.net:27017 --db tate --collection artworks --type json --file artworks.json --jsonArray --authenticationDatabase admin --ssl  --username ***your_username***

mongoimport --host **your***primary***cluster.mongodb.net:27017 --db tate --collection artists --type json --file artists.json --jsonArray --authenticationDatabase admin --ssl  --username ***your_username***

//This data have been retrieved at the Tate github repository:
//https://github.com/tategallery/collection
//I've modified data structure

//to load locally
//data retrieved from https://nijianmo.github.io/amazon/index.html
mongoimport --db=amazon --collection=music  --file=CDs_and_Vinyl_5.json

// 2. Query and Projection Operators

// 2.1 Comparison
// $eq, $ne

db.artists.find(
    {
        activePlaceCount: {$eq: 2}
    }, 
    {
        _id:0, 
        mda:1, 
        activePlaceCount:1
    }
);


db.artists.find(
    {
        totalWorks: {$ne: 1}
    }, 
    {
        _id:0, 
        mda:1, 
        totalWorks:1
    }
); 

// $gt, $gte, $lt, $lte

db.artists.find(
    {
        "birth.time.startYear": {$gt: 1950}
    }, 
    {
        _id:0, 
        mda:1, 
        "birth.time.startYear":1
    }
); 

db.artists.find(
    {
        "birth.time.startYear": {$gte: 1950, $lt: 1960}
    }, 
    {
        _id:0, 
        mda:1, 
        "birth.time.startYear":1
    }
); 

// $in, $nin

db.artists.find(
    {
        "birth.place.placeName": {
            $in: ["Chicago", "New York"]
        }
    }, 
    {
        _id:0, 
        mda:1, 
        "birth.place.placeName":1
    }
); 

db.artists.find(
    {
        activePlaceCount: {
            $nin: [0, 2]
        }
    }, 
    {
        _id:0, 
        mda:1, 
        activePlaceCount:1
    }
); 

// composite query

db.artists.find(
    {
        "birth.time.startYear": {$gte: 1920, $lt: 1930},
        "birth.place.placeName": {
        $in: ["Barcelona", "Madrid"]}
    },
    {
        _id: 0,
        mda:1, 
        "birth.time.startYear":1,
        "birth.place.placeName":1
    }
);

// 2.2 Element Operators
// $exist

db.artworks.find(
    {
        movements: {$exists: true}
    }
).itcount();

db.artworks.find(
    {
        movements: {$exists: false}
    }
).itcount();

// $type

db.artworks.find(
    {
        inscription: {$type: "string"}
    }
).itcount();

// 2.3 Logical Operators
// $or

db.artworks.find(
    {
        $or: [
            {"dateRange.startYear": {$gte: 1963, $lte: 1964}},
            {"dateRange.endYear": {$gte: 1964, $lte: 1965}}
        ]
    },
    {
        _id:0,
        "dateRange.startYear":1,
        "dateRange.endYear":1
    }
);

// $and 
// spot the difference:

db.artworks.find(
    {
        $and: [
            {"dateRange.startYear": {$gte: 1963, $lte: 1964}},
            {"dateRange.endYear": {$gte: 1964, $lte: 1965}}
        ]
    }
).itcount();

db.artworks.find(
    {
        "dateRange.startYear": {$gte: 1963, $lte: 1964},
        "dateRange.endYear": {$gte: 1964, $lte: 1965}
    }
).itcount();

// to specify multiple selectors on the same key

db.artworks.find(
    {
        $and: [
            {inscription: {$ne: null}},
            {inscription: {$exists: true}}]
    }
).itcount();

//2.4 Array Operators
//$all

db.artists.find(
    {movNames: {$all: ["Conceptual Art", "Performance Art"]}},
    {_id:0, movNames:1}
);

//$size

db.artists.find(
    {movNames: {$size:3}},
    {_id:0, mda:1, movNames:1}
);

db.artists.find({movNames: {$size:3}}).itcount();

// $elemMatch

// update a field, nested into a document, nested into an array
db.artists.updateOne(
    {
        mda: "Reynolds, Sir Joshua",
        "movements.id": 341
    },
    {$set: 
        {"movements.$.id": 3}
    });

//spot the difference:

db.artists.find(
    {
        "movements.id" : {$gt: 340},
        "movements.name": "Fancy Picture"
    },
    {_id:0, mda:1, movements:1}
);

db.artists.find(
    {"movements": 
        {$elemMatch: {"id" : {$gt: 340}, "name": "Fancy Picture"}}
    },
    {_id:0, mda:1, movements:1}
);

// 2.5 Evaluation (regular expressions)

//Obama at the beginning
db.music.find(
    {
        reviewerName: {$regex: /Obama/}
    },
    {
        _id:0,
        reviewerName:1
    }
);


db.music.find(
    {
        reviewText: {$regex: /([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)/}
    },
    {
        _id:0,
        reviewText:1
    }
).limit(3);

// 3. The aggregation framework

// 3.1 Match
// match is a filter that uses the same syntax as find

db.artists.aggregate(
    [{$match:
        {
            movements: {$size: 2}
        }
    }]
).itcount();

db.artists.find(
    {
        movements: {$size: 2}
    }
).itcount();

// 3.2 Project
// project allows us to reassign and create new fields
 
db.artists.aggregate(
    [{
        $project: {_id:0, mda:1, "birth.time.startYear":1, "death.time.startYear":1}
    }]
);

db.artists.aggregate(
    [{
        $project: {_id:0, mda:1, birth: "$birth.time.startYear", death: "$death.time.startYear"}
    }]
);

//2014 is the year of the last update of the GitHub repository
db.artists.aggregate(
    [{
        $project: {
            _id:0, 
            mda:1,
            birth:"$birth.time.startYear", 
            death:"$death.time.startYear",
            age: { $cond: {
                if: {$ne : ["$death", undefined]}, 
                then: {$subtract: ["$death.time.startYear", "$birth.time.startYear"]}, 
                else: {$subtract: [2014, "$birth.time.startYear"]}
            }}
        }
    }]
);


// 3.3 Group Stage

db.artworks.aggregate([
    {
        $group: {_id: "$acquisitionYear"}
    }]);

 db.artworks.aggregate([
    {
        $group: {
            _id: "$acquisitionYear",
            numAcquisitions: {$sum:1}
        }
    },
    {
        $sort: {numAcquisitions:-1}
    }]
);


// $project, $match, $group

db.artists.aggregate(
    [{
        $project: {
                _id:0,
                age: { $cond: {
                if: {$ne : ["$death", undefined]}, 
                then: {$subtract: ["$death.time.startYear", "$birth.time.startYear"]}, 
                else: {$subtract: [2014, "$birth.time.startYear"]}
            }}
        }
    },
    {
        $match: {age:{$gt:25, $lt:35}}
    },
    {
        $group: {
            _id: "$age",
            count: {$sum:1}
        }
    }]
);

// stage one

db.artists.aggregate(
    [{
        $project: {
                _id:0,
                mda:1,
                age: { $cond: {
                if: {$ne : ["$death", undefined]}, 
                then: {$subtract: ["$death.time.startYear", "$birth.time.startYear"]}, 
                else: {$subtract: [2014, "$birth.time.startYear"]}
            }}
        }
    }]
);

// stages one and two

db.artists.aggregate(
    [{
        $project: {
                _id:0,
                mda:1,
                age: { $cond: {
                if: {$ne : ["$death", undefined]}, 
                then: {$subtract: ["$death.time.startYear", "$birth.time.startYear"]}, 
                else: {$subtract: [2014, "$birth.time.startYear"]}
                }}
        }
    },
    {
        $match: {age:{$gt:25, $lt:35}}
    }]
);

// $out

db.artists.aggregate(
    [{
        $project: {
                _id:0,
                age: { $cond: {
                if: {$ne : ["$death", undefined]}, 
                then: {$subtract: ["$death.time.startYear", "$birth.time.startYear"]}, 
                else: {$subtract: [2014, "$birth.time.startYear"]}
            }}
        }
    },
    {
        $match: {age:{$gt:25, $lt:35}}
    },
    {
        $group: {
            _id: "$age",
            count: {$sum:1}
        }
    },
    {
        $out: "outputOne"
    }]
);

// 3.5 Output and Export

// .json export
mongoexport --host "***your***primary***cluster.mongodb.net:27017" --db tate --collection outputOne --out outputOne.json --authenticationDatabase admin --ssl  --username ***your-username***

// .csv export
mongoexport --host "***your***primary***cluster.mongodb.net:27017" --db tate --collection outputOne --type csv --fields _id,count --out outputOne.csv --authenticationDatabase admin --ssl  --username ***your-username***