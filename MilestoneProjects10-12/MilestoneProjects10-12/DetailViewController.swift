import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    
    var filename: String?
    var caption: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let filename = filename else { return }
        guard let caption = caption else { return }
        
        photoView.image = UIImage(named: filename)
        captionLabel.text = caption
    }
}
