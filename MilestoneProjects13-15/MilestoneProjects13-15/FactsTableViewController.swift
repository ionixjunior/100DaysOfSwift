import UIKit

class FactsTableViewController: UITableViewController {
    var country: Country!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let country = country {
            title = country.name
        }
    }
    
}
