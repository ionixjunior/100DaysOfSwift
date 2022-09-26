import UIKit

// review of optionals
var name1: String = "John"
var name2: String?
var name3: String! // implicitly unwrapped optionals
print("The name 1 is " + name1)
//print("The name 2 is " + name2) // Xcode will tell us that we need to unwrap the optional
//print("The name 3 is " + name3) // Xcode will tell us that the unwrapped value is nil


// review of enums
enum Direction {
    case left, right, top, bottom
}

func move(to direction: Direction) {
    if direction == .left { print("Moving left") }
    if direction == .right { print("Moving right") }
    if direction == .top { print("Moving top") }
    if direction == .bottom { print("Moving bottom") }
}

move(to: .left)
move(to: .top)
