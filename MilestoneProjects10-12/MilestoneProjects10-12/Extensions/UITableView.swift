import UIKit

extension UITableView {
    func showEmpty(message: String) {
        let label = UILabel()
        label.text = message
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        backgroundView = label
    }
}
