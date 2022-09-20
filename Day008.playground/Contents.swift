import UIKit

// creating structs
struct Person {
    var first: String
    var last: String
    
    // computed property
    var fullname: String {
        return "\(first) \(last)"
    }
}

let johnSmith = Person(first: "John", last: "Smith")
print(johnSmith.fullname)
