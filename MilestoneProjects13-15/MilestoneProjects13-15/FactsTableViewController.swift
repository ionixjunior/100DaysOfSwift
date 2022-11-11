import UIKit

class FactsTableViewController: UITableViewController {
    var country: Country!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let country = country {
            title = country.name
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Fact", for: indexPath)
        
        let data = getData(from: indexPath.row)
        var config = cell.defaultContentConfiguration()
        config.text = data.name
        config.secondaryText = data.description
        cell.contentConfiguration = config
        
        return cell
    }
    
    private func getData(from: Int) -> (name: String, description: String) {
        switch from {
        case 0:
            return ("Capital City", country.facts.capitalCity)
        case 1:
            return ("Official Languages", country.facts.officialLanguages.map {$0.name}.joined(separator: ", "))
        case 2:
            return ("Size", String(country.facts.size))
        case 3:
            return ("Population", String(country.facts.population))
        case 4:
            return ("Currency", country.facts.currency)
        default:
            return ("", "")
        }
    }
}
