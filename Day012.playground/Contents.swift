import UIKit

// handling missing data
var name: String?
var age: Int? = nil


// unwrapping optionals
func unwrap(value: String?) {
    if let unwrapped = value {
        print("The value is \(unwrapped)")
    } else {
        print("The value is nil")
    }
}

func unwrapWithGuard(value: String?) {
    guard let unwrapped = value else {
        print("The value is nil")
        return
    }
    
    print("The value is \(unwrapped)")
}

unwrap(value: name)
unwrapWithGuard(value: name)
name = "Samantha"
age = 35
unwrap(value: name)
unwrapWithGuard(value: name)


// force unwrapping optionals
var city: String? = "London"
print(city)
print(city!)


// nil coalescing
func getUsernameById(_ id: Int) -> String? {
    id == 1 ? "samantha" : nil
}

getUsernameById(10) ?? "anonymous"


// optional chaining
let names = [1: "Samantha", 2: "Jorge"]
let someName = names[10]?.uppercased()


// optional try
enum PasswordError: Error {
    case empty
}

func checkPassword(password: String) throws -> Bool {
    if password.isEmpty {
        throw PasswordError.empty
    }
    
    return true
}

if let resultCheckPassword = try? checkPassword(password: "") {
    print("Password check result: \(resultCheckPassword)")
} else {
    print("There is a problem with the password")
}


// failable initializers
struct User {
    var username: String
    var password: String
    
    init?(username: String, password: String) {
        guard username.isEmpty == false else { return nil }
        guard password.count >= 6 else { return nil }
        
        self.username = username
        self.password = password
    }
}

let user1 = User(username: "", password: "")
let user2 = User(username: "samantha", password: "123")
let user3 = User(username: "samantha", password: "123456")


// typecasting
class Animal {}
class Fish: Animal {}
class Dog: Animal {
    func makeNoise() {
        print("Au au au!")
    }
}

let animals = [Dog(), Fish(), Fish(), Dog()]
for animal in animals {
    if let dog = animal as? Dog {
        dog.makeNoise()
    }
}
