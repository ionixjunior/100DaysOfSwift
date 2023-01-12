struct Card: Equatable {
    let name: String
    let group: Int
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.group == rhs.group
    }
}
