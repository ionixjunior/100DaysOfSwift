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
}

let johnSmith = Person(first: "John", last: "Smith")
print(johnSmith.fullname)
print(johnSmith.numberOfMessages())


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
