import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meme generator"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }

    @objc func addTapped() {
        let controller = UIImagePickerController()
        controller.allowsEditing = true
        controller.delegate = self
        present(controller, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        imageView.image = image
        picker.dismiss(animated: true) {
            self.requestTopText()
        }
    }
    
    func requestTopText() {
        let alert = UIAlertController(title: "Enter the top text", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        alert.addAction(UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let text = alert.textFields?.first?.text else { return }
            guard let image = self?.imageView.image else { return }
            
            let renderer = UIGraphicsImageRenderer(size: image.size)
            let imageWithText = renderer.image { _ in
                image.draw(at: CGPoint(x: 0, y: 0))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = NSTextAlignment.center
                
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont(name: "impact", size: 100) as Any,
                    .foregroundColor: UIColor.white,
                    .paragraphStyle: paragraphStyle
                ]
                
                let attributedString = NSAttributedString(string: text, attributes: attributes)
                attributedString.draw(with: CGRect(x: 0, y: 10, width: image.size.width, height: image.size.height), options: .usesLineFragmentOrigin, context: nil)
            }
            
            self?.imageView.image = imageWithText
            self?.requestBottomText()
        })
        self.present(alert, animated: true)
    }
    
    func requestBottomText() {
        let alert = UIAlertController(title: "Enter the bottom text", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        alert.addAction(UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let text = alert.textFields?.first?.text else { return }
            guard let image = self?.imageView.image else { return }
            
            let renderer = UIGraphicsImageRenderer(size: image.size)
            let imageWithText = renderer.image { _ in
                image.draw(at: CGPoint(x: 0, y: 0))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = NSTextAlignment.center
                
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont(name: "impact", size: 100) as Any,
                    .foregroundColor: UIColor.white,
                    .paragraphStyle: paragraphStyle
                ]
                
                let attributedString = NSAttributedString(string: text, attributes: attributes)
                attributedString.draw(with: CGRect(x: 0, y: image.size.height - 140, width: image.size.width, height: image.size.height), options: .usesLineFragmentOrigin, context: nil)
            }
            
            self?.imageView.image = imageWithText
        })
        self.present(alert, animated: true)
    }
}

