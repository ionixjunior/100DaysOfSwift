import UIKit

// creating classes
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
    
    func makeNoise() {
        print("Au!")
    }
}

var dog = Dog(name: "Teco", breed: "Yorkshire")
dog.makeNoise()


// class inheritance
class Yorkshire: Dog {
    init(name: String) {
        super.init(name: name, breed: "Yorkshire")
    }
    
    override func makeNoise() {
        print("Au Au Au Au Au!")
    }
}

var teco = Yorkshire(name: "Teco")
teco.makeNoise()
