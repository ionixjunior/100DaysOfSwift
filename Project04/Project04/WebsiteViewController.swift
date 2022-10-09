import UIKit

class WebsiteViewController: UITableViewController {
    let websites = ["ionixjunior.com.br", "apple.com", "hackingwithswift.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Websites"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)

        if #available(iOS 14.0, *) {
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = websites[indexPath.row]
            cell.contentConfiguration = contentConfiguration
        } else {
            cell.textLabel?.text = websites[indexPath.row]
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "WebViewPage") as? ViewController {
            viewController.website = websites[indexPath.row]
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
