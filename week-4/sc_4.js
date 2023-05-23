//let's interact with our mongo shell, and let's inspect some basic commands:
help
db.help()
exit

//CRUD operations (create, read, update, delete) through the Mongo Shell
//
// 1. Create

// 1.1 Inset One
show dbs
use tate 
show dbs // if you "show dbs" nothing has changed, why?
db // Let's see what database are we using

db.artworks.insertOne(
    {
        "title" : "Cottage and Hilly Landscape", 
        "artist": "Thomas Hand", 
        "year": 1797, 
        "classification" : "painting"
    });

//MongoDB created an _id for us, let's try to provide one:

db.artworks.insertOne(
    {
        "_id": "N02474", 
        "title" : "Cottage and Hilly Landscape", 
        "artist": "Thomas Hand", 
        "year": 1797, 
        "classification" : "painting"
    });

//Inserted through Compass

db.artworks.insertOne(
    {
        "_id": "N02411", 
        "title" : "Studies for Work", 
        "artist": "Ford Madox Brown", 
        "year": 1855, 
        "classification" : "on paper, unique"
    });

// 1.2 Insert Many -- Ordered

db.artworks.insertMany([
    {
        "_id": "N02352",
        "title": "Street in a Near Eastern Town",
        "artist": "William James Muller",
        "year": 1838,
        "classification": "on paper, unique"
    },
    {
        "_id": "N02459",
        "title": "Drawing for Punch",
        "artist": "Charles Samuel Keene",
        "year": null,
        "classification": "on paper, unique"
    },
    { 
        "_id": "N02440",
        "title": "Sancta Lilias",
        "artist": "Dante Gabriel Rossetti", 
        "year": 1987, 
        "classification" : "painting"
    },
    {
        "_id": "N02474",
        "title" : "Cottage and Hilly Landscape", 
        "artist": "Thomas Hand", 
        "year": 1797, 
        "classification" : "painting"
    },
    {
        "_id": "N02352",
        "title": "Street in a Near Eastern Town",
        "artist": "William James Muller",
        "year": 1838,
        "classification": "on paper, unique"
    },
    {
        "_id": "N02424",
        "title": "The Ponte Delle Torri, Spoleto",
        "artist": "Joseph Mallord William Turner",
        "year" : 1845,
        "classification": "painting"
    },
]);

// 1.2.1 Insert Many -- Unordered

db.artworks.insertMany([
    {
        "_id": "N02352",
        "title": "Street in a Near Eastern Town",
        "artist": "William James Muller",
        "year": 1838,
        "classification": "on paper, unique"
    },
    {
        "_id": "N02459",
        "title": "Drawing for Punch",
        "artist": "Charles Samuel Keene",
        "year": null,
        "classification": "on paper, unique"
    },
    { 
        "_id": "N02440",
        "title": "Sancta Lilias",
        "artist": "Dante Gabriel Rossetti", 
        "year": 1987, 
        "classification" : "painting"
    },
    {
        "_id": "N02474",
        "title" : "Cottage and Hilly Landscape", 
        "artist": "Thomas Hand", 
        "year": 1797, 
        "classification" : "painting"
    },
    {
        "_id": "N02352",
        "title": "Street in a Near Eastern Town",
        "artist": "William James Muller",
        "year": 1838,
        "classification": "on paper, unique"
    },
    {
        "_id": "N02424",
        "title": "The Ponte Delle Torri, Spoleto",
        "artist": "Joseph Mallord William Turner",
        "year" : 1845,
        "classification": "painting"

    }],
    {"ordered": false}
);

// 2. Read operations
// let's start with some basic read operation

//db.collection.find({querySelector},{someProjection}) 

db.artworks.find() 
db.artworks.find().pretty()

//let's project only title and author

db.artworks.find({},{title:1, artist:1}).pretty()
db.artworks.find({},{_id:0, title:1, artist:1})

//let's add a query selector
db.artworks.find({artist: 'Thomas Hand'}, {_id:0, title:1, artist:1})

// 3. Update operations

// 3.1 Update One

db.artworks.updateOne({"title": "Street in a Near Eastern Town"},
    {$set:
        {"medium": "Graphite and watercolour on paper"}
    });

db.artworks.updateOne({"_id": "N02459"},
    {$set:
        {"medium": "Ink on paper"}
    });

db.artworks.updateOne({"_id": "N02459"},
    {$unset:
        {"year":""}
    });

db.artworks.find({"_id":"N02459"}).pretty()

// 3.2 Update Many

db.artworks.updateMany({
    classification:"painting"},
    {$set:
        {"medium": "Oil paint on canvas"}
    });

db.artworks.updateMany({},
    {$set:
        {"contributorCount": 1}
    });

// 3.3 Update with objects

db.artworks.updateOne({"_id": "N02459"},
    {$set: {
        "contributor": {
            "birthYear": 1823,
            "date": "1823–1891",
            "gender": "Male",
            "mda": "Keene, Charles Samuel",
            "role": "artist"
        }
    }}
);

// 3.4 Replace vs Update

db.artworks.replaceOne({"_id": "N02474"}, {"error": "Not Available"});

// 4. Delete operations

db.artworks.deleteOne({"_id": "N02474"});

db.artworks.deleteMany({"classification" : "painting"});

db.artworks.drop();

show dbs
