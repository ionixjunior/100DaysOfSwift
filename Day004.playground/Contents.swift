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
