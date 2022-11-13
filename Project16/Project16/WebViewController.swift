import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var placeName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let placeName = placeName else { return }
        title = placeName
        
        guard let encodedPlaceName = placeName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "https://en.wikipedia.org/wiki/\(encodedPlaceName)") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        
        navigationController?.isToolbarHidden = false
    }
}
