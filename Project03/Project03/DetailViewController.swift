import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: String!
    var currentPicture: Int!
    var totalOfPictures: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Picture \(currentPicture ?? 0) of \(totalOfPictures ?? 0)"
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)?.applyWatermark()
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        }
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 1) else { return }
        
        let viewController = UIActivityViewController(activityItems: [selectedImage ?? "Picture", image], applicationActivities: [])
        
        if #available(iOS 16.0, *) {
            viewController.popoverPresentationController?.sourceItem = navigationItem.rightBarButtonItem
        } else {
            viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        }
        
        present(viewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
