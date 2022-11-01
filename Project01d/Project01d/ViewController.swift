import UIKit

class ViewController: UITableViewController {
    private var pictures = [Picture]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = UIColor.systemBackground
        
        let fileManager = FileManager.default
        let resourcePath = Bundle.main.resourcePath!
        let content = try! fileManager.contentsOfDirectory(atPath: resourcePath)
        pictures = PictureLoader.loadPicturesFrom(content: content)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommendTapped))
    }
    
    @objc func recommendTapped() {
        let viewController = UIActivityViewController(activityItems: ["I liked this app and I believe that you will like too! Please, check this out!"], applicationActivities: [])
        
        if #available(iOS 16.0, *) {
            viewController.popoverPresentationController?.sourceItem = navigationItem.rightBarButtonItem
        } else {
            viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        }
        
        present(viewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        return updateCell(cell, text: pictures[indexPath.row].name)
    }
    
    private func updateCell(_ cell: UITableViewCell, text: String) -> UITableViewCell {
        if #available(iOS 14.0, *) {
            return updateCellUsingContentConfiguration(cell, text: text)
        }
        
        return updateCellUsingLegacyWay(cell, text: text)
    }
    
    private func updateCellUsingContentConfiguration(_ cell: UITableViewCell, text: String) -> UITableViewCell {
        var content = cell.defaultContentConfiguration()
        content.text = text
        content.textProperties.font = UIFont.preferredFont(forTextStyle: .title1)
        cell.contentConfiguration = content
        return cell
    }
    
    private func updateCellUsingLegacyWay(_ cell: UITableViewCell, text: String) -> UITableViewCell {
        cell.textLabel?.text = text
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row].name
            vc.currentPicture = pictures[indexPath.row].position
            vc.totalOfPictures = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

