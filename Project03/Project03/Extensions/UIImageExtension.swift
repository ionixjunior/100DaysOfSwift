import UIKit

extension UIImage {
    func applyWatermark() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.size)
        let imageWithWatermark = renderer.image { _ in
            let picture = self
            picture.draw(at: CGPoint(x: 0, y: 0))
            
            let text = "From Storm View app"
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 30),
                .backgroundColor: UIColor.white.withAlphaComponent(0.5),
            ]
            
            let attributedString = NSAttributedString(string: text, attributes: attributes)
            attributedString.draw(with: CGRect(x: 10, y: 10, width: self.size.width, height: self.size.height), options: .usesLineFragmentOrigin, context: nil)
        }
        
        return imageWithWatermark
    }
}
