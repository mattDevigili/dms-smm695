// 1. Create a new db smm695 and an empty collection hmw4
//use smm695;
db.createCollection('hm4');

// 2. Insert the following:

db.hm4.insertMany([
    {'name':'Traveling Wilburys', 'birth': 1988, 'members': ['Bob Dylan', 'George Harrison', 'Jeff Lynne', 'Roy Orbison', 'Tom Petty'], 'breakup': 1991},
    {'name':'Temple of the Dog', 'birth': 1990, 'members': ['Chris Cornell', 'Jeff Ament', 'Matt Cameron', 'Stone Gossard', 'Mike McCready', 'Eddie Vedder'], 'breakup': 1992},
    {'name':'The White Stripes', 'birth': 1997, 'members': ['Jack White', 'Meg White'], 'breakup': 2011},
    {'name':'The Three Tenors', 'birth': 1990, 'members': ['Plácido Domingo', 'José Carreras', 'Luciano Pavarotti'], 'breakup': 2007},
    {'name':'LSD', 'birth': 2018, 'members': ['Sia Furler', 'Timothy McKenzie', 'Wesley Pentz']}
]);
// 3. Add a new field albums with the following values:

db.hm4.updateOne({'name':'Traveling Wilburys'}, {$set:{'album':4}});
db.hm4.updateOne({'name':'Temple of the Dog'}, {$set:{'album':1}});
db.hm4.updateOne({'name':'The Three Tenors'}, {$set:{'album':14}});
db.hm4.updateOne({'name':'LSD'}, {$set:{'album':1}});

// 4. Modify Traveling Wilburys with The Traveling Wilburys

db.hm4.updateOne({'name':'Traveling Wilburys'}, {$set:{'name':'The Traveling Wilburys'}});

// 5. Delete The White Stripes

db.hm4.deleteOne({'name': 'The White Stripes'});

// 6. Count the number of 'superbands' formed before 1990 (use .itcount())

db.hm4.find({'birth': {$lt: 1990}}).itcount();