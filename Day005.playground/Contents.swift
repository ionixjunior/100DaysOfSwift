import UIKit

// writing functions
func printMessage() {
    print("You have 1 new message!")
}

printMessage()

// accepting parameters
func sum(firstValue: Int, secondValue: Int) {
    print(firstValue + secondValue)
}

sum(firstValue: 1, secondValue: 5)


// returning values
func getSum(firstValue: Int, secondValue: Int) -> String {
    let result = firstValue + secondValue
    return "The sum is \(result)"
}
getSum(firstValue: 1, secondValue: 5)

func divisibleBy2(number: Int) -> Bool {
    number % 2 == 0
}
divisibleBy2(number: 7)

func getUsername() -> (first: String, last: String) {
    ("John", "Smith")
}
let username = getUsername()
print("\(username.first) \(username.last)")


// parameter labels
func sayHello(to name: String) {
    print("Hello, \(name)!")
}
sayHello(to: "John")


// omitting parameter labels
func printUsername(_ first: String, _ last: String) {
    print("\(first) \(last)")
}
printUsername("John", "Smith")


// default parameters
func sum(_ value1: Int, _ value2: Int, multiply: Bool = false) -> Int {
    let result = value1 + value2
    
    if multiply {
        return result * result
    }
    
    return result
}
sum(1, 3)
sum(1, 3, multiply: true)


// variadic functions
func printNumbers(numbers: Int...) {
    for number in numbers {
        print(number)
    }
}
printNumbers(numbers: 1, 2, 4, 8)
