import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!

    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
