import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var placeName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let placeName = placeName {
            title = placeName
        }
    }
}
