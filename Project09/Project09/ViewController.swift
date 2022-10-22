import UIKit

class ViewController: UITableViewController {
    private var allPetitions = [Petition]()
    private var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTitle(text: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(creditTapped))
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        loadData()
    }
    
    private func showTitle(text: String?) {
        if let text = text {
            title = text
        } else {
            title = "Petitions"
        }
    }
    
    @objc private func filterTapped() {
        let alert = UIAlertController(title: "What do you want to filter?", message: "The filter will be applied only for titles.", preferredStyle: .alert)
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "Clear", style: .cancel, handler: { _ in
            self.filteredPetitions = self.allPetitions
            self.showTitle(text: nil)
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Filter", style: .default, handler: { [weak alert] _ in
            if let text = alert?.textFields?.first?.text {
                self.filteredPetitions = self.allPetitions.filter { petition in
                    return petition.title.lowercased().contains(text.lowercased())
                }
                
                self.showTitle(text: text)
                self.tableView.reloadData()
            }
        }))
        
        present(alert, animated: true)
    }
    
    @objc private func creditTapped() {
        let alert = UIAlertController(title: "Where is the data comes from?", message: "The data comes from The People API of the Whitehouse.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func loadData() {
        tableView.refreshControl?.beginRefreshing()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Loading data...")
        let urlString = getUrlString()
        loadUrlAndParseJson(urlString)
    }
    
    fileprivate func loadUrlAndParseJson(_ urlString: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self.parse(data: data)
                    return
                }
            }
            
            self.showError()
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
            allPetitions = decodedPetitions.results
            filteredPetitions = allPetitions
            
            DispatchQueue.main.async {
                self.showTitle(text: nil)
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.refreshControl?.attributedTitle = NSAttributedString(string: "")
            }
        }
    }
    
    private func showError() {
        let alert = UIAlertController(title: "Something wrong", message: "Fail to load the page. Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.update(title: petition.title, subtitle: petition.body)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        viewController.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}

