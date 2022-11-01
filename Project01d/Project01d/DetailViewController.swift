import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewersLabel: UILabel!
    var selectedImage: String!
    var currentPicture: Int!
    var totalOfPictures: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Picture \(currentPicture ?? 0) of \(totalOfPictures ?? 0)"
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
            
            let viewersKey = "viewers_of_\(imageToLoad)"
            let defaults = UserDefaults.standard
            var numberOfViewers = defaults.integer(forKey: viewersKey)
            numberOfViewers += 1
            defaults.set(numberOfViewers, forKey: viewersKey)
            viewersLabel.text = "This storm image was shown \(numberOfViewers) time(s)."
        }
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
