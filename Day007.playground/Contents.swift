import UIKit

// closures accepting parameters
func showNumberOfMessages(action: (Int) -> Void) {
    action(5)
}

showNumberOfMessages { (number: Int) in
    print("You have \(number) messages.")
}


// closures returning values
func getNumberOfMessages(action: (Int) -> String) {
    let result = action(10)
    print(result)
}

getNumberOfMessages { (number: Int) -> String in
    return "You have \(number) messages."
}


// shorthand parameter names
getNumberOfMessages { number in
    "You have \(number) messages."
}

getNumberOfMessages {
    "You have \($0) messages."
}


// closures with multiple parameters
func inboxSummary(action: (String, Int) -> String) {
    let result = action("John", 20)
    print(result)
}

inboxSummary { (name: String, number: Int) in
    "Hello, \(name)! You have \(number) messages."
}

inboxSummary {
    "Hello, \($0)! You have \($1) messages."
}
