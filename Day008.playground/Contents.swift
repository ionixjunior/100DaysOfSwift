import UIKit

// creating structs
struct Person {
    var first: String
    var last: String
    
    // computed property
    var fullname: String {
        return "\(first) \(last)"
    }
    
    func numberOfMessages() -> String {
        return "You have 3 new messages!"
    }
    
    mutating func toMarry(last newLastname: String) {
        last = newLastname
    }
}

var johnSmith = Person(first: "John", last: "Smith")
print(johnSmith.fullname)
print(johnSmith.numberOfMessages())
johnSmith.toMarry(last: "Adams")
print(johnSmith.fullname)


// property observers
struct Progress {
    var amount: Int {
        willSet {
            print("The amount will change...")
        }
        didSet {
            print("The amount was changed to \(amount)%")
        }
    }
}

var progress = Progress(amount: 0)
progress.amount = 10
progress.amount = 30
progress.amount = 70
progress.amount = 100


// properties and methods of strings
let text = "My name is John!"
text.lowercased()
text.uppercased()
text.hasPrefix("Hello")
text.hasPrefix("My")
text.hasPrefix("my")
text.count
text.sorted()
text.contains("Samantha")
text.contains("John")


// properties and methods of arrays
var colors = ["Red"]
colors.count
colors.append("Green")
colors.firstIndex(of: "Red")
colors.sorted()
