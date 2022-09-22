import UIKit

// creating classes
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

var dog = Dog(name: "Teco", breed: "Yorkshire")


// class inheritance
class Yorkshire: Dog {
    init(name: String) {
        super.init(name: name, breed: "Yorkshire")
    }
}

var teco = Yorkshire(name: "Teco")
