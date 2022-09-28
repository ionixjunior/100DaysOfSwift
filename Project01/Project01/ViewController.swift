import UIKit

class ViewController: UITableViewController {
    private var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileManager = FileManager.default
        let resourcePath = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: resourcePath)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        print(pictures)
    }


}

