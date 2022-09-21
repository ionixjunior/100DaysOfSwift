import UIKit

// initializers
struct UserType {
}
struct User {
    var username: String
    lazy var type = UserType()
}

extension User {
    init() {
        self.username = "Anonymous"
    }
}

var laura = User(username: "Laura")
laura.username
laura
laura.type
laura

var samantha = User()
samantha.username = "Samantha"
samantha.username


