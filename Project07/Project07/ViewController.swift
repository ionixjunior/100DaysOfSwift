import UIKit

class ViewController: UITableViewController {
    private var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://www.hackingwithswift.com/samples/petitions-1.json") {
            if let data = try? Data(contentsOf: url) {
                parse(data: data)
            }
        }
    }
    
    private func parse(data: Data) {
        let jsonDecoder = JSONDecoder()
        if let decodedPetitions = try? jsonDecoder.decode(Petitions.self, from: data) {
            petitions = decodedPetitions.results
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
}

