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
