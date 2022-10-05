import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
        addCountries()
    }
    
    func addCountries() {
        countries += [
            Country(name: "Estonia", flag: "estonia"),
            Country(name: "France", flag: "france"),
            Country(name: "Germany", flag: "germany"),
            Country(name: "Ireland", flag: "ireland"),
            Country(name: "Italy", flag: "italy"),
            Country(name: "Monaco", flag: "monaco"),
            Country(name: "Nigeria", flag: "nigeria"),
            Country(name: "Poland", flag: "poland"),
            Country(name: "Russia", flag: "russia"),
            Country(name: "Spain", flag: "spain"),
            Country(name: "UK", flag: "uk"),
            Country(name: "US", flag: "us")
        ]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country")!
        let country = countries[indexPath.row]
        
        if #available(iOS 16.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = country.name
            content.image = UIImage(named: country.flag)
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = country.name
            cell.imageView?.image = UIImage(named: country.flag)
        }
        
        return cell
    }
}

