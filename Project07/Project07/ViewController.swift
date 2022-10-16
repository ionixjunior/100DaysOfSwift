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
        
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: "https://www.hackingwithswift.com/samples/petitions-1.json") {
                if let data = try? Data(contentsOf: url) {
                    self.parse(data: data)
                }
            }
        }
    }
    
    private func parse(data: Data) {
        let jsonDecoder = JSONDecoder()
        if let decodedPetitions = try? jsonDecoder.decode(Petitions.self, from: data) {
            petitions = decodedPetitions.results
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
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
}

