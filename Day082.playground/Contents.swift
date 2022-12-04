// Milestone of projects 22-24

import UIKit

extension UIView {
    func bouceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            view.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            view.backgroundColor = .red
        })
    }
}

let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
view.backgroundColor = .yellow
view.bouceOut(duration: 2)


extension Int {
    func times (action: () -> Void) {
        for _ in 1...self {
            action()
        }
    }
}

3.times {
    print("Hello world!")
}


extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let index = self.firstIndex(of: item) {
            self.remove(at: index)
        }
    }
}

var people = ["Samantha", "Taylor", "Laura", "Jorge", "Taylor"]
people.remove(item: "Taylor")
people
