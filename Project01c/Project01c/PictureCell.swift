import UIKit

class PictureCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func update(name: String) {
        self.name.text = name
        self.imageView.image = UIImage(named: name)
    }
}
