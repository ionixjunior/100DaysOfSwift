import UIKit

protocol Identifiable {
    var id: Int { get set }
}

protocol FirstName {
    var first: String { get set }
}

protocol LastName {
    var last: String { get set }
}

protocol Fullname: FirstName, LastName {
    func getFullname() -> String
}

struct User: Identifiable, Fullname {
    var id: Int
    var first: String
    var last: String
    
    func getFullname() -> String {
        "\(first) \(last)"
    }
}

func displayID(_ identifiable: Identifiable) {
    print("The ID is \(identifiable.id)")
}

func displayFullname(_ fullname: Fullname) {
    print("The full name is \(fullname.getFullname())")
}

let user = User(id: 1, first: "Samantha", last: "Miller")
displayID(user)
displayFullname(user)


// extensions
extension Double {
    func humanize(symbol: String) -> String {
        "\(symbol)\(self)"
    }
}

let price = 10.0
price.humanize(symbol: "$")
