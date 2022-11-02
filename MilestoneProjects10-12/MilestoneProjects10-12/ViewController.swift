import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var memories = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Memories"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appending(path: imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.5) {
            try? jpegData.write(to: imagePath)
        }
        
        let alert = UIAlertController(title: "What is the name of your memory?", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Save", style: .default) {
            [weak picker, weak alert, weak self] _ in
            
            let caption = alert?.textFields?.first?.text ?? ""
            let photo = Photo(filename: imagePath.getPath(), caption: caption)
            
            self?.memories.append(photo)
            self?.tableView.reloadData()
            
            picker?.dismiss(animated: true)
        })
        
        picker.present(alert, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath) as! PhotoCell
        let photo = memories[indexPath.row]
        cell.update(filename: photo.filename, caption: photo.caption)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        let photo = memories[indexPath.row]
        detailViewController.filename = photo.filename
        detailViewController.caption = photo.caption
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            _, _, completionHandler in
            
            completionHandler(true)
            self.memories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let renameAction = UIContextualAction(style: .normal, title: "Rename") {
            _, _, completionHandler in
            
            var photo = self.memories[indexPath.row]
            let alert = UIAlertController(title: "What is the name of your memory?", message: nil, preferredStyle: .alert)
            alert.addTextField()
            alert.addAction(UIAlertAction(title: "Update", style: .default) {
                [weak alert, weak self] _ in
                
                let caption = alert?.textFields?.first?.text ?? ""
                photo = Photo(filename: photo.filename, caption: caption)
                self?.memories[indexPath.row] = photo
                self?.tableView.reloadRows(at: [indexPath], with: .automatic)
                
                completionHandler(true)
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .default) {
                _ in
                completionHandler(true)
            })
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, renameAction])
    }
}

