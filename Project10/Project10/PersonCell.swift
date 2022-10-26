import UIKit

class PersonCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func update(name: String, image: String) {
        self.name.text = name
        self.imageView.image = UIImage(contentsOfFile: image)
    }
}
