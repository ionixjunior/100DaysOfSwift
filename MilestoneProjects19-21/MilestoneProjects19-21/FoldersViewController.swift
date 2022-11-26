import UIKit

class FoldersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Folders"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
    }
    
    @objc func editTapped() {
        
    }
}

