//
//  WebsiteViewController.swift
//  Project04
//
//  Created by Ione Souza Junior on 08/10/22.
//

import UIKit

class WebsiteViewController: UITableViewController {
    let websites = ["ionixjunior.com.br", "apple.com", "hackingwithswift.com"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
