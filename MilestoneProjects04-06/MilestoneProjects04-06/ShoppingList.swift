class ShoppingList {
    private (set) var items = [String]()
    
    func add(item: String) {
        items.append(item)
    }
    
    func clear() {
        items.removeAll()
    }
}
