import UIKit

class PhotoCell: UITableViewCell {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(filename: String, caption: String) {
        photoView.image = UIImage(named: filename)
        captionLabel.text = caption
    }
}
