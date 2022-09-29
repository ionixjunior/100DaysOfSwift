import UIKit

class ViewController: UITableViewController {
    private var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fileManager = FileManager.default
        let resourcePath = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: resourcePath)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        return updateCell(cell, text: pictures[indexPath.row])
    }
    
    private func updateCell(_ cell: UITableViewCell, text: String) -> UITableViewCell {
        if #available(iOS 14.0, *) {
            return updateCellUsingContentConfiguration(cell, text: text)
        }
        
        return updateCellUsingLegacyWay(cell, text: text)
    }
    
    private func updateCellUsingContentConfiguration(_ cell: UITableViewCell, text: String) -> UITableViewCell {
        var content = cell.defaultContentConfiguration()
        content.text = text
        cell.contentConfiguration = content
        return cell
    }
    
    private func updateCellUsingLegacyWay(_ cell: UITableViewCell, text: String) -> UITableViewCell {
        cell.textLabel?.text = text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

