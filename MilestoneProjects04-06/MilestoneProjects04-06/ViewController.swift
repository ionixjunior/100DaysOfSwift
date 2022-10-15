import UIKit

class ViewController: UITableViewController {
    private var shoppingList: ShoppingList!

    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingList = ShoppingList()
    }
}

