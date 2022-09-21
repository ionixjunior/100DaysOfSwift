import UIKit

// initializers
struct UserType {
}
struct User {
    static var numberOfUsers = 0
    var username: String
    lazy var type = UserType()
}

extension User {
    init() {
        self.username = "Anonymous"
        User.numberOfUsers += 1
    }
}

var laura = User(username: "Laura")
laura.username
laura
laura.type
laura

User.numberOfUsers
var samantha = User()
samantha.username = "Samantha"
samantha.username

User.numberOfUsers
var anonimous = User()
User.numberOfUsers


// access control
struct Product {
    private var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func getIdentifier() -> String {
        "The product ID is \(id)"
    }
}

let product = Product(id: 1, name: "Bicycle")
product.getIdentifier()
