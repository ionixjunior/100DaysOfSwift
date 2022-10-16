import UIKit

extension UITableViewCell {
    func update(text: String) {
        if #available(iOS 14.0, *) {
            var contentConfiguration = self.defaultContentConfiguration()
            contentConfiguration.text = text
            self.contentConfiguration = contentConfiguration
        } else {
            self.textLabel?.text = text
        }
    }
    
    func update(title: String, subtitle: String) {
        if #available(iOS 14.0, *) {
            var contentConfiguration = self.defaultContentConfiguration()
            contentConfiguration.text = title
            contentConfiguration.secondaryText = subtitle
            self.contentConfiguration = contentConfiguration
        } else {
            self.textLabel?.text = title
            self.detailTextLabel?.text = subtitle
        }
    }
}
