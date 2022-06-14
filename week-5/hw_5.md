# Homework 5

Load the sample data provided by MongoDB into your Atlas cluster.

## Task One

For task one, we are going to work with `sample_weatherdata.data`. You should
select only documents that match the following criteria:

* `callLetters` is "SHIP"
* `pressure.value` is greater than 2000
* `atmosphericPressureChange.tendency.code` falls between 4 and 7
* `precipitationEstimatedObservation.discrepancy` is equal to 2

In order to perform this task, you need to create a variable as follows:

```java
var match = {$match: {...}}
```

How many documents match these conditions?

> Answer: 3

## Task Two

Define a project stage in order to:

* not display `_id`
* display `ts`, `position.coordinates`, `callLetters`
* rename `pressure.value` as pressure
* rename `atmosphericPressureChange.tendency.code` as change
* rename `precipitationEstimatedObservation.discrepancy` as discrepancy

Create a new variable as follows:

```java
var project = {$project: {...}}
```
Pass both the `match` stage defined in _task one_ and the newly created 
`project` within your aggregation pipeline.

This is the expected output:

```java
{
	"ts" : ISODate("1984-03-08T12:00:00Z"),
	"position" : {
		"coordinates" : [
			171.2,
			23.2
		]
	},
	"callLetters" : "SHIP",
	"pressure" : 9999.9,
	"change" : "4",
	"discrepancy" : "2"
}
```
```java
{
	"ts" : ISODate("1984-03-12T18:00:00Z"),
	"position" : {
		"coordinates" : [
			4.5,
			49.5
		]
	},
	"callLetters" : "SHIP",
	"pressure" : 9999.9,
	"change" : "6",
	"discrepancy" : "2"
}
```
```java
{
	"ts" : ISODate("1984-03-12T12:00:00Z"),
	"position" : {
		"coordinates" : [
			-9.1,
			43.6
		]
	},
	"callLetters" : "SHIP",
	"pressure" : 9999.9,
	"change" : "6",
	"discrepancy" : "2"
}
```

## Task Three

Let's turn to `tate.artists`. You are required to design an aggregation, doing the following:

* select all documents for which the value of `gender` is equal to _"Female"_
* group observations on the basis of movement names (to do that you should
    deconstruct the `movNames` array with **$unwind**)
* retrieve the 5 most frequent movements

This is the expected result:

```java
{ "_id" : "Feminist Art", "count" : 18 }
{ "_id" : "Performance Art", "count" : 10 }
{ "_id" : "Young British Artists (YBA)", "count" : 9 }
{ "_id" : "Conceptual Art", "count" : 9 }
{ "_id" : "Abject art", "count" : 8 }
```