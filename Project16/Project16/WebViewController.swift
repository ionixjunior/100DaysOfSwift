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
        
        let goBack = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBackTapped))
        let goForward = UIBarButtonItem(title: "Forward", style: .plain, target: self, action: #selector(goForwardTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshTapped))
        toolbarItems = [goBack, goForward, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }
    
    @objc func goBackTapped() {
        webView.goBack()
    }
    
    @objc func goForwardTapped() {
        webView.goForward()
    }
    
    @objc func refreshTapped() {
        webView.reload()
    }
}
