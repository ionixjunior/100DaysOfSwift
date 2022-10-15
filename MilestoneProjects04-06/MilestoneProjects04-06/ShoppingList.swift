class ShoppingList {
    private (set) var items = [String]()
    
    func add(item: String) {
        items.append(item)
    }
    
    func clear() {
        items.removeAll()
    }
    
    func getPlainText() -> String {
        var prefixedItems = [String]()
        
        for item in items {
            prefixedItems.append("- \(item)")
        }
        
        return prefixedItems.joined(separator: "\n")
    }
    
    var total: Int {
        return items.count
    }
}
