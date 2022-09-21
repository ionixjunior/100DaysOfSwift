import UIKit

// initializers
struct User {
    var username: String
}

extension User {
    init() {
        self.username = "Anonymous"
    }
}

var laura = User(username: "Laura")
laura.username

var samantha = User()
samantha.username = "Samantha"
samantha.username

