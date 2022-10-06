import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let url = URL(string: "https://ionixjunior.dev")!
        webView.load(URLRequest(url: url))
    }
    
    @objc func openTapped() {
        let alertController = UIAlertController(title: "Choose a page to open", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "ionixjunior.dev", style: .default, handler: pageTapped))
        alertController.addAction(UIAlertAction(title: "apple.com", style: .default, handler: pageTapped))
        alertController.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: pageTapped))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if #available(iOS 16.0, *) {
            alertController.popoverPresentationController?.sourceItem = navigationItem.rightBarButtonItem
        } else {
            alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        }
        
        present(alertController, animated: true)
    }
    
    func pageTapped(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://\(actionTitle)") else { return }
        
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}

