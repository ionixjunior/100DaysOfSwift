import UIKit

// closures accepting parameters
func showNumberOfMessages(action: (Int) -> Void) {
    action(5)
}

showNumberOfMessages { (number: Int) in
    print("You have \(number) messages.")
}
