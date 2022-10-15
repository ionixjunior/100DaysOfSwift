class ShoppingList {
    private (set) var items = [String]()
    
    func add(item: String) {
        items.insert(item, at: 0)
    }
    
    func clear() {
        items.removeAll()
    }
    
    func itemFrom(position: Int) -> String {
        return items[position]
    }
    
    var plainText: String {
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
