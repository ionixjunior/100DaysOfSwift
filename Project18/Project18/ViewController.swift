import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(1, 2, 3, "teste", separator: "-", terminator: ":")
        print("abc")
        
        for i in 1...100 {
            print("The numer is", i)
        }
        
        assert(1 == 1, "Math failure!")
        assert(1 == 2, "Math failure!")
    }


}

