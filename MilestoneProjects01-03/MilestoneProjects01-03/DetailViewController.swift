import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    
    var name: String!
    var flag: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = name
        image.image = UIImage(named: flag)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    @objc func shareTapped() {
        
    }
}
