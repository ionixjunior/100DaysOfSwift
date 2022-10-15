import UIKit

class ViewController: UITableViewController {
    private var shoppingList: ShoppingList!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping list"
        shoppingList = ShoppingList()
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

