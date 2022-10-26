import UIKit

class PersonCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func update(name: String, image: String) {
        self.name.text = name
        self.imageView.image = UIImage(contentsOfFile: image)
    }
    
    func addBorders() {
        imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 3
        self.backgroundColor = UIColor.systemGray4
        self.layer.cornerRadius = 7
    }
}
