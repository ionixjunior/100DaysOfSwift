import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView = UIProgressView(progressViewStyle: .default)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let progress = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        toolbarItems = [progress, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        let url = URL(string: "https://ionixjunior.dev")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
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
    
    @objc func refreshTapped() {
        webView.reload()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}

