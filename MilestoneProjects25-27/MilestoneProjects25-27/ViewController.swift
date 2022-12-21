import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meme generator"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }

    @objc func addTapped() {
        let controller = UIImagePickerController()
        controller.allowsEditing = true
        present(controller, animated: true)
    }
}

