import UIKit

// for loops
let names = ["John", "Samantha"]
for name in names {
    print("The name is \(name)")
}

let numbers = 1...5
for _ in numbers {
    print("More one number")
}

// while loops
var countdown = 5
while countdown > 0 {
    print(countdown)
    countdown -= 1
}

// repeat loops
var total = 1
repeat {
    print("Total: \(total)")
    total += 1
} while total <= 5

repeat {
    print("This print will be executed once")
} while false

while false {
    print("This print will never be executed")
}

// exiting loops
var number = 1
while number <= 10 {
    print(number)
    
    if number == 5 {
        print("No more numbers")
        break
    }
    
    number += 1
}

// exiting multiple loops
outerLoop: for i in 1...5 {
    for j in 1...5 {
        print("i = \(i)  - j = \(j)")
        
        if j == 3 {
            break outerLoop
        }
    }
}
