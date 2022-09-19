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


// returning values from a closure
let getMessageFrom = { (name: String) -> String in
    return "Hello, \(name)! You have 4 new messages!"
}
getMessageFrom("Samantha")


// closures as parameters
let showSomeMessage = {
    print("Some message here")
}

func greetings(action: () -> Void) {
    print("Hello!")
    action()
    print("End of greetings func")
}
greetings(action: showSomeMessage)
