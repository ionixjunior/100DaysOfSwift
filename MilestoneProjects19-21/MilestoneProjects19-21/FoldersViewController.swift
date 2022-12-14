import UIKit

class FoldersViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var folders = [Folder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Folders"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        
        tableView.layer.cornerRadius = 10
        tableView.dataSource = self
        loadFolders()
    }
    
    @objc func editTapped() {
        
    }
    
    func loadFolders() {
        guard let url = Bundle.main.url(forResource: "folders", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            folders = try JSONDecoder().decode([Folder].self, from: data)
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Folder", for: indexPath)
        let folder = folders[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = folder.name
        content.secondaryText = folder.totalNotes.description
        
        var imageName = "folder"
        if folder.type == .Smart {
            imageName = "gearshape"
        } else if folder.type == .Deleted {
            imageName = "trash"
        }
        
        content.image = UIImage(systemName: imageName)
        cell.contentConfiguration = content
        
        return cell
    }
}

