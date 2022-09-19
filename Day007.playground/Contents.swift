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
