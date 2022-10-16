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
            contentConfiguration.textProperties.lineBreakMode = .byTruncatingTail
            contentConfiguration.textProperties.numberOfLines = 1
            contentConfiguration.secondaryText = subtitle
            contentConfiguration.secondaryTextProperties.lineBreakMode = .byTruncatingTail
            contentConfiguration.secondaryTextProperties.numberOfLines = 3
            self.contentConfiguration = contentConfiguration
        } else {
            self.textLabel?.text = title
            self.detailTextLabel?.text = subtitle
        }
    }
}
