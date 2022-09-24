import UIKit

protocol Identifiable {
    var id: Int { get set }
}

struct User: Identifiable {
    var id: Int
}

func displayID(_ identifiable: Identifiable) {
    print("The ID is \(identifiable.id)")
}

let user = User(id: 1)
displayID(user)
