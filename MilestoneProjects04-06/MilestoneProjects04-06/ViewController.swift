import UIKit

class ViewController: UITableViewController {
    private var shoppingList: ShoppingList!

    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingList = ShoppingList()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.total
    }
}

