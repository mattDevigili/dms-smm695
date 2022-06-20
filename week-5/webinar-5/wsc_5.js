// 0 Compass and Aggregation

// Localhost --- Moma
use moma

db.artworks.aggregate([
    {$match: {
        "Classification":"Architecture",
        "Characteristics.Medium": {$regex: 'ink', $options: 'i'},
        "Characteristics.Height": {$gte: 100}}
    }
]);

// Localhost --- Amazon
use amazon

db.music.aggregate([
    {$group:{
        _id:"$asin",
        avg:{
            $avg: "$overall"
        },
        count:{
            $sum: 1
        }
    }
    },
    {$sort:{
        avg: 1
    }}
]);


// Atlas --- sample training
use sample_training

db.tweets.aggregate([
    {$match: {
        "user.location":"London",
        "user.followers_count": {$gt: 100},
        "$expr": {$gt: [{$size: "$entities.user_mentions"}, 0]}
    }},
    {$unwind:{
        path:"$entities.user_mentions"
    }},
    {$project:{
        user_mentions: "$entities.user_mentions.name"
    }},
    {$group:{
        _id: "$user_mentions",
        count: {
            $sum: 1
        }
    }},
    {$sort: {
        count:-1
    }}
]);


// 1 Cursor methods
// Localhost
use moma

// .limit()
db.artworks.find().limit(2);

// .skip()
db.artworks.find().limit(2).skip(1);

// .sort()
db.artworks.find({}, {Title:1, Date:1}).sort({_id:1});

db.artworks.find({}, {Title:1, Date:1}).sort({_id:-1});

// .itcount()
db.artworks.find({Date: {$type: "string"}}).itcount();

db.artworks.aggregate({$match: {Date: {$type: "string"}}}).itcount();

// .explain():
db.artworks.explain().find({Date: {$gt: 1900}});


// 2 Cursor-like stages

//Atlas
use tate

// $limit
db.artists.aggregate(
    [{
        $project: {_id:0, mda:1, birth: "$birth.time.startYear", death: "$death.time.startYear"}
    },
    {
        $limit: 3
    }]
);

// $skip
db.artists.aggregate(
    [{
        $project: {_id:0, mda:1, birth: "$birth.time.startYear", death: "$death.time.startYear"}
    },
    {
        $limit: 3
    },
    {
        $skip: 1
    }]
);

db.artists.aggregate(
    [{
        $project: {_id:0, mda:1, birth: "$birth.time.startYear", death: "$death.time.startYear"}
    },
    {
        $skip: 1
    },
    {
        $limit: 3
    }]
);


// $sort
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
    },
    {
        $sort: {age:-1}
    }]
);


// sorting on multiple values
db.artists.aggregate([
    {
        $project: {_id:0, activePlaceCount:1, totalWorks:1}
    },
    {
        $sort: {activePlaceCount:-1, totalWorks:-1}
    }]
);


// $count
db.artists.aggregate(
    [{
        $project: {
            age: { $cond: {
                if: {$ne : ["$death", undefined]}, 
                then: {$subtract: ["$death.time.startYear", "$birth.time.startYear"]}, 
                else: {$subtract: [2014, "$birth.time.startYear"]}
            }}
        }
    },
    {
        $match: {age: {$eq:27}}
    }]
).itcount();


db.artists.aggregate(
    [{
        $project: {
            age: { $cond: {
                if: {$ne : ["$death", undefined]}, 
                then: {$subtract: ["$death.time.startYear", "$birth.time.startYear"]}, 
                else: {$subtract: [2014, "$birth.time.startYear"]}
            }}
        }
    },
    {
        $match: {age: {$eq:27}}
    },
    {
        $count: "27club"
    }]
);


//3 Aggregations

// Create a new field to store the size of movNames array:
// { $cond: { if: <boolean-expression>, then: <true-case>, else: <false-case> } }
db.artists.aggregate([
    {
        $project: {
            _id:0,
            numMov: {
                    $cond: [{$isArray: "$movNames"}, {$size: "$movNames"}, 0]
                },
            movNames: 1
            }
    },
    {
        $sort: {numMov:-1}
    }]
);

db.artists.aggregate([
    {
        $project: {
            _id:0,
            numMov: {
                    $cond: [{$isArray: "$movNames"}, {$size: "$movNames"}, 0]
                },
            movNames: 1
            }
    },
    {
        $sort: {numMov:1}
    }]
);


//group + sum
db.artists.aggregate([
    {
        $group: {
            _id: {
                numMov: {
                    $cond: [{$isArray: "$movNames"}, {$size: "$movNames"}, 0]
                }
            },
            freq: {$sum: 1},
        }
    },
    {
        $sort: {freq:-1}
    }]
);


// group + avg
db.artists.aggregate([
    {
        $group: {
            _id: {
                numMov: {
                    $cond: [{$isArray: "$movNames"}, {$size: "$movNames"}, 0]
                }
            },
            freq: {$sum: 1},
            avgWorks: {$avg: "$totalWorks"}
        }
    },
    {
        $sort: {freq:-1}
    }]
);

// group + max
db.artists.aggregate([
    {
        $group: {
            _id: {
                numMov: {
                    $cond: [{$isArray: "$movNames"}, {$size: "$movNames"}, 0]
                }
            },
            freq: {$sum: 1},
            maxWorks: {$max: "$totalWorks"}
        }
    },
    {
        $sort: {freq:-1}
    }]
);

db.artists.aggregate([
    {
        $match: {mda: {$ne: "Turner, Joseph Mallord William"}}
    },
    {
        $group: {
            _id: {
                numMov: {
                    $cond: [{$isArray: "$movNames"}, {$size: "$movNames"}, 0]
                }
            },
            freq: {$sum: 1},
            avgWorks: {$avg: "$totalWorks"}
        }
    },
    {
        $sort: {freq:-1}
    }]
);

// group + min
db.artists.aggregate([
    {
        $group: {
            _id: {
                numMov: {
                    $cond: [{$isArray: "$movNames"}, {$size: "$movNames"}, 0]
                }
            },
            freq: {$sum: 1},
            minWorks: {$min: "$totalWorks"}
        }
    },
    {
        $sort: {freq:-1}
    }]
);

// Some stats

// $addFields + $match
db.artists.aggregate(
    [{
        $addFields: {
            age: { $cond: {
                if: {$ne : ["$death", undefined]}, 
                then: {$subtract: ["$death.time.startYear", "$birth.time.startYear"]}, 
                else: {$subtract: [2014, "$birth.time.startYear"]}
            }}
        }
    },
    {
        $match: {age: {$gt: 0}}
    },
    ]);

// let's add a group stage
db.artists.aggregate(
    [{
        $addFields: {
            age: { $cond: {
                if: {$ne : ["$death", undefined]}, 
                then: {$subtract: ["$death.time.startYear", "$birth.time.startYear"]}, 
                else: {$subtract: [2014, "$birth.time.startYear"]}
            }}
        }
    },
    {
        $match: {age: {$gt: 0}}
    },
    {
        $group: {
            _id: {
                numMov: {
                    $cond: [{$isArray: "$movNames"}, {$size: "$movNames"}, 0]
                }
            },
            freq: {$sum: 1},
            avgWorks: {$avg: "$totalWorks"},
            minWorks: {$min: "$totalWorks"},
            maxWorks: {$max: "$totalWorks"},
            std: {$stdDevPop: "$totalWorks"},
            avgAge: {$avg: "$age"}
        }
    }
    ]);

// Let's add another field, unset _id, and sort
db.artists.aggregate(
    [{
        $addFields: {
            age: { $cond: {
                if: {$ne : ["$death", undefined]}, 
                then: {$subtract: ["$death.time.startYear", "$birth.time.startYear"]}, 
                else: {$subtract: [2014, "$birth.time.startYear"]}
            }}
        }
    },
    {
        $match: {age: {$gt: 0}}
    },
    {
        $group: {
            _id: {
                numMov: {
                    $cond: [{$isArray: "$movNames"}, {$size: "$movNames"}, 0]
                }
            },
            freq: {$sum: 1},
            avgWorks: {$avg: "$totalWorks"},
            minWorks: {$min: "$totalWorks"},
            maxWorks: {$max: "$totalWorks"},
            std: {$stdDevPop: "$totalWorks"},
            avgAge: {$avg: "$age"}
        }
    },
    {
        $addFields: {countMovements: "$_id.numMov"}
    },
    {
        $unset: "_id"
    },
    {
        $sort: {countMovements:1}
    }
    ]);

// Let's export the result
db.artists.aggregate(
    [{
        $addFields: {
            age: { $cond: {
                if: {$ne : ["$death", undefined]}, 
                then: {$subtract: ["$death.time.startYear", "$birth.time.startYear"]}, 
                else: {$subtract: [2014, "$birth.time.startYear"]}
            }}
        }
    },
    {
        $match: {age: {$gt: 0}}
    },
    {
        $group: {
            _id: {
                numMov: {
                    $cond: [{$isArray: "$movNames"}, {$size: "$movNames"}, 0]
                }
            },
            freq: {$sum: 1},
            avgWorks: {$avg: "$totalWorks"},
            minWorks: {$min: "$totalWorks"},
            maxWorks: {$max: "$totalWorks"},
            std: {$stdDevPop: "$totalWorks"},
            avgAge: {$avg: "$age"}
        }
    },
    {
        $addFields: {countMovements: "$_id.numMov"}
    },
     {
        $unset: "_id"
    },
    {
        $sort: {countMovements:1}
    },
    {
        $out: "artistStats"
    }
]);

// 4. Working with date

// Localhost
use amazon

// reviewTime is a string that I want to cast to date
db.music.aggregate( [ 
{
   $project: {
       _id:0,
       reviewTime:1,
       date: {
           $dateFromString: {
               dateString: '$reviewTime',
               format: "%m %d, %Y"
           }
       }
   }
} 
]);

// Setting a new field "date":
db.music.updateMany({}, [
    {$set: { date: {
         $dateFromString: {
            dateString: '$reviewTime',
            format: "%m %d, %Y"         
         }
    }}
}]
);

// Extract some info and appending back
db.music.updateMany({},[
    {$set: {year: {$year: "$date"}}},
    {$set: {month: {$month: "$date"}}},
    {$set: {day: {$dayOfMonth: "$date"}}}
]);

//Convert Unix 
// a unix timestamp is the amount of seconds between a date and the 
// Unix Epoch Jan 1, 1970.
// $toDate requires milliseconds since Jan 1 1970, so I need to 
// multiply by 1000
db.music.aggregate([
  {
    $project: { 
        _id:0,
        date:1,
        unixReviewTime:1,
        unixDate: {$toDate: {$multiply: ['$unixReviewTime', 1000]}} 
    }
  }
]);


// 5. Get a sample of the collection

// If all the following conditions are met, $sample uses a pseudo-random cursor to select documents:
// * $sample is the first stage of the pipeline
// * N is less than 5% of the total documents in the collection
// * The collection contains more than 100 documents
// If any of the above conditions are NOT met, $sample performs a collection scan followed by a random
// sort to select N documents. In this case, the $sample stage is subject to the sort memory restrictions.
db.music.aggregate([
    {
        $sample: {size: 1000}
    },
    {
        $out: "sampleMusic"
    }
]);

// export sample collection
mongoexport --collection=sampleMusic --db=amazon --out=Desktop/sampleMusic.json