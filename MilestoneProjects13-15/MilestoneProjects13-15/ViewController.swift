import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .userInteractive).async {
            if let path = Bundle.main.path(forResource: "countries", ofType: "json") {
                do {
                    if let jsonData = try String(contentsOfFile: path).data(using: .utf8) {
                        if let countries = try? JSONDecoder().decode([Country].self, from: jsonData) {
                            self.countries = countries
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
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

