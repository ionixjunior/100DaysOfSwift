import UIKit

extension UIActivityViewController {
    func configurePopoverPresentationController(item: UIBarButtonItem) {
        if #available(iOS 16.0, *) {
            self.popoverPresentationController?.sourceItem = item
        } else {
            self.popoverPresentationController?.barButtonItem = item
        }
    }
}
