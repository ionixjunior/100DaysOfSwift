import UIKit

extension UITableViewCell {
    func update(text: String) {
        if #available(iOS 14.0, *) {
            var config = self.defaultContentConfiguration()
            config.text = text
            self.contentConfiguration = config
        } else {
            self.textLabel?.text = text
        }
    }
    
    func update(title: String, subtitle: String) {
        if #available(iOS 14.0, *) {
            var config = self.defaultContentConfiguration()
            config.text = title
            config.textProperties.lineBreakMode = .byTruncatingTail
            config.textProperties.numberOfLines = 1
            config.secondaryText = subtitle
            config.secondaryTextProperties.lineBreakMode = .byTruncatingTail
            config.secondaryTextProperties.numberOfLines = 3
            self.contentConfiguration = config
        } else {
            self.textLabel?.text = title
            self.detailTextLabel?.text = subtitle
        }
    }
}
