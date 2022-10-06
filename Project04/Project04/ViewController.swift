import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    
    override func loadView() {
        let url = URL(string: "https://ionixjunior.dev")!
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.load(URLRequest(url: url))
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

