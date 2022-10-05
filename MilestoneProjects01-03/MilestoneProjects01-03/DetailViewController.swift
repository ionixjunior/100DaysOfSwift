import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    
    var name: String!
    var flag: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = name
    }
}
