import UIKit

// creating basic closures
let showMessages = {
    print("You have 3 new messages")
}
showMessages()


// accepting parameters in a closure
let showNameAndNumberOfMessages = { (name: String, number: Int) in
    print("Hello \(name)! You have \(number) new messages!")
}
showNameAndNumberOfMessages("John", 5)
