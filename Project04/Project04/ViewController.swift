import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    let websites = ["ionixjunior.com.br", "apple.com", "hackingwithswift.com"]
    var website: String!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let website = website else { return }
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let back = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: #selector(backTapped))
        let progress = UIBarButtonItem(customView: progressView)
        let forward = UIBarButtonItem(title: "Forward", style: .plain, target: nil, action: #selector(forwardTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        toolbarItems = [back, progress, forward, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        let url = URL(string: "https://" + website)!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @objc func backTapped() {
        webView.goBack()
    }
    
    @objc func forwardTapped() {
        webView.goForward()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    @objc func openTapped() {
        let alertController = UIAlertController(title: "Choose a page to open", message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
            alertController.addAction(UIAlertAction(title: website, style: .default, handler: pageTapped))
        }
        
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
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = getHostFrom(url: url) {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        decisionHandler(.cancel)
        showAccessDeniedMessageFrom(url: url)
    }
    
    private func getHostFrom(url: URL?) -> String? {
        if #available(iOS 16.0, *) {
            guard let url = url else { return nil }
            if url.absoluteString == "about:blank" { return nil }
            return url.host()
        }
        
        return url?.host
    }
    
    private func showAccessDeniedMessageFrom(url: URL?) {
        guard let url = url else { return }
        
        let alert = UIAlertController(title: "Access denied", message: "Sorry, you don't have permission to access \"\(url.absoluteString)\".", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

