//1. Task One
use sample_weatherdata

var match = { $match: 
    {
        "atmosphericPressureChange.tendency.code": {$in: ["4", "5", "6", "7"]},
        "pressure.value": {$gt: 2000}, 
        "callLetters": "SHIP", 
        "precipitationEstimatedObservation.discrepancy":"2"
    }
};

db.data.aggregate([match]).itcount()

//2. Task Two
var project = {$project:
    {
        _id:0,
        ts:1,
        "position.coordinates":1,
        callLetters:1,
        pressure: "$pressure.value",
        change: "$atmosphericPressureChange.tendency.code",
        discrepancy: "$precipitationEstimatedObservation.discrepancy"
    }
};

db.data.aggregate([match, project])

//3. Task Three
use tate

db.artists.aggregate([
    {
        $match: {gender:"Female"}
    },
    {
        $unwind: {path: "$movNames"}
    },
    {
        $group: {
            _id: "$movNames",
            count: {$sum: 1}
        }
    },
    {
        $sort: {count:-1}
    },
    {
        $limit: 5
    }
]);