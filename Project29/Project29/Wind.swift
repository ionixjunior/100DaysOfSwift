import UIKit

struct Wind {
    let direction: WindDirection
    let strength: CGFloat
    
    var description: String {
        return "The wind is on the \(direction == WindDirection.left ? "left" : "right") and your strength is \(strength)"
    }
    
    var dxValue: CGFloat {
        if direction == WindDirection.left {
            return strength * -1
        }
        
        return strength
    }
}
