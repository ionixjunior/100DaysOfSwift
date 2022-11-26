import UIKit

class FoldersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Folders"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        
        loadFolders()
    }
    
    @objc func editTapped() {
        
    }
    
    func loadFolders() {
        guard let url = Bundle.main.url(forResource: "folders", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = try JSONDecoder().decode([Folder].self, from: data)
            
        } catch {
            print(error)
        }
    }
}

