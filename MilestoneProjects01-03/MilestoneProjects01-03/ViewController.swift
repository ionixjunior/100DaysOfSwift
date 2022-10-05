import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}

