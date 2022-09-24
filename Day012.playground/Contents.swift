import UIKit

// handling missing data
var name: String?
var age: Int? = nil


// unwrapping optionals
func unwrap(value: String?) {
    if let unwrapped = value {
        print("The value is \(unwrapped)")
    } else {
        print("The value is nil")
    }
}

unwrap(value: name)
name = "Samantha"
age = 35
unwrap(value: name)


