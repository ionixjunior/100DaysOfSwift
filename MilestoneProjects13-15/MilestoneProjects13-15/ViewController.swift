import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        
        var config = cell.defaultContentConfiguration()
        config.text = countries[indexPath.row].name
        cell.contentConfiguration = config
        
        return cell
    }
}

