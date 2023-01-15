import UIKit

struct Card: Equatable {
    let image: UIImage
    let group: Int
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.group == rhs.group
    }
}
