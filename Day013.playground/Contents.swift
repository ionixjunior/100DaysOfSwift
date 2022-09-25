import UIKit

// review about accuracy of numbers
let floatNumber: Float = 123.12345678987654321
let doubleNumber: Double = 123.12345678987654321
let decimalNumber: Decimal = 123.12345678987654321


// review about array concat
let arrayA = ["John", "Samantha"]
let arrayB = ["Jorge", "Laura", "Dayana"]
let arrayC = arrayA + arrayB


// review about range and switch
let range1 = 0...10
let range2 = 11...20
type(of: range1)

let value = 13

switch value {
case range1:
    print("Range 1 selected!")
case range2:
    print("Range 2 selected!")
default:
    print("Unknown range")
}
