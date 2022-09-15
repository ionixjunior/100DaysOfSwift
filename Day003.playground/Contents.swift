import UIKit

// arithmetic operators
let value1 = 10
let value2 = 20
let sum = value1 + value2
let sub = value1 - value2
let division = value1 / value2
let multiply = value1 * value2
let daysOfYear = 365
let daysOfWeek = 7
let weeksOfYear = daysOfYear / daysOfWeek
let isMultiple = 30.isMultiple(of: 4)

// operator overloading
let firstName = "John"
let lastName = "Smith"
let fullName = firstName + " " + lastName
let mainFruits = ["Apple", "Banana"]
let otherFruits = ["Avocado"]
let allFruits = mainFruits + otherFruits

// compound assignment operators
var score = 5
score += 10
score -= 4
score *= 2
score /= 11
var description = "This description is not "
description += "a loren ipsun."

// comparison operators
let numberOfPointsPlayerA = 10
let numberOfPointsPlayerB = 15
numberOfPointsPlayerA == numberOfPointsPlayerB
numberOfPointsPlayerA != numberOfPointsPlayerB
numberOfPointsPlayerA >= numberOfPointsPlayerB
numberOfPointsPlayerA < numberOfPointsPlayerB
"Swift" == "swift"
"Swift" == "Swift"
"Swift" != "tfiwS"
"swift" <= "SWIFT"

// conditions
if numberOfPointsPlayerA > numberOfPointsPlayerB {
    print("Player A wins")
} else if numberOfPointsPlayerA < numberOfPointsPlayerB {
    print("Player B wins")
} else {
    print("All the players win")
}
