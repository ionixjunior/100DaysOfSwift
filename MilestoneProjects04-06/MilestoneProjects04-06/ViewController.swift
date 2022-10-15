import UIKit

class ViewController: UITableViewController {
    private var shoppingList: ShoppingList!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping list"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        toolbarItems = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        ]
        navigationController?.isToolbarHidden = false
        shoppingList = ShoppingList()
    }
    
    @objc func clearTapped() {
        let alert = UIAlertController(title: "Are you sure you want to clear the list?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            self.shoppingList.clear()
            self.tableView.reloadData()
        })
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc func addTapped() {
        let alert = UIAlertController(title: "What do you want to add?", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Add", style: .default) { [weak alert] _ in
            if let item = alert?.textFields?[0].text {
                self.shoppingList.add(item: item)
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc func shareTapped() {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.total
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.update(text: shoppingList.itemFrom(position: indexPath.row))
        return cell
    }
}

