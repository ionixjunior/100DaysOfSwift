import UIKit

class ViewController: UITableViewController {
    private var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        loadData()
    }
    
    @objc private func loadData() {
        tableView.refreshControl?.beginRefreshing()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Loading data...")
        let urlString = getUrlString()
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self.parse(data: data)
                }
            }
        }
    }
    
    private func getUrlString() -> String {
        if navigationController?.tabBarItem.tag == 0 {
            return "https://www.hackingwithswift.com/samples/petitions-1.json"
        }
        
        return "https://www.hackingwithswift.com/samples/petitions-2.json"
    }
    
    private func parse(data: Data) {
        let jsonDecoder = JSONDecoder()
        if let decodedPetitions = try? jsonDecoder.decode(Petitions.self, from: data) {
            petitions = decodedPetitions.results
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.refreshControl?.attributedTitle = NSAttributedString(string: "")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.update(title: petition.title, subtitle: petition.body)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        viewController.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}

