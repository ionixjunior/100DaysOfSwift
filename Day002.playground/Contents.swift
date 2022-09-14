import UIKit

// arrays
let ferrari = "Ferrari"
let mclaren = "McLaren"
let mercedes = "Mercedes"
let cars = [ferrari, mclaren, mercedes]
cars[0]
cars[1]
let bicycles: [String] = ["Caloi", "Sundonw", "Houston"]

// sets
let tires = Set(["Goodyer", "Michelin", "Goodyer", "GOODYER", "Bridgestone"])

// tuples
let name = (first: "Ayrton", last: "Senna")
name.0
name.1
name.first
name.last

// dictionaries
let students = [
    "Paul": "B",
    "Samantha": "A+"
]
students["Samantha"]

let numberOfCards: [String: Int] = [
    "Paul": 10,
    "Samantha": 14
]
numberOfCards["Paul"]
numberOfCards["Pedro"]

// empty collections
var numberOfWins = [String: Int]()
numberOfWins["Samantha"] = 10
numberOfWins["Paul"] = 3

var words = Set<String>()
words.insert("good")
words.insert("bad")
words

var scores = Dictionary<String, Int>()
scores["Samantha"] = 332

var results = Array<Double>()
results.append(10.0)
