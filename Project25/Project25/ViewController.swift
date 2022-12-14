import UIKit
import MultipeerConnectivity

class ViewController: UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate, MCNearbyServiceAdvertiserDelegate {
    var images = [UIImage]()
    
    var peerID = MCPeerID(displayName: UIDevice.current.name)
    var mcSession: MCSession?
    var mcNearbyServiceAdvertiser: MCNearbyServiceAdvertiser?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Selfie Share"
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPromptTapped)),
            UIBarButtonItem(title: "Devices", style: .plain, target: self, action: #selector(showConnectedDevicesTapped))
        ]
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraTapped)),
            UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(sendMessageTapped))
        ]
        
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
    }
    
    @objc func showConnectionPromptTapped() {
        let alert = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        alert.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    func startHosting(action: UIAlertAction) {
        mcNearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "hws-project25")
        mcNearbyServiceAdvertiser?.delegate = self
        mcNearbyServiceAdvertiser?.startAdvertisingPeer()
    }
    
    func joinSession(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        let mcBrowser = MCBrowserViewController(serviceType: "hws-project25", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    
    @objc func showConnectedDevicesTapped() {
        guard let mcSession = mcSession else { return }
        
        var message = ""
        
        if mcSession.connectedPeers.count > 0 {
            message = "Here is the list of connected devices:\n"
            for peers in mcSession.connectedPeers {
                message += "\n- \(peers.displayName)"
            }
        } else {
            message = "No devices connected."
        }
        
        let alert = UIAlertController(title: "Connected devices", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    @objc func cameraTapped() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func sendMessageTapped() {
        let alert = UIAlertController(title: "Send your message", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Send", style: .default) {
            [weak self] _ in
            guard let text = alert.textFields?.first?.text else { return }
            guard let mcSession = self?.mcSession else { return }
            
            let textData = Data(text.utf8)
            
            do {
                try mcSession.send(textData, toPeers: mcSession.connectedPeers, with: .reliable)
            } catch {
                let alert = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self?.present(alert, animated: true)
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        
        images.insert(image, at: 0)
        collectionView.reloadData()
        
        guard let mcSession = mcSession else { return }
        if mcSession.connectedPeers.count > 0 {
            if let imageData = image.pngData() {
                do {
                    try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch {
                    let alert = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    present(alert, animated: true)
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
        
        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = images[indexPath.item]
        }
        
        return cell
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("Connected: \(peerID.displayName)")
            
        case .connecting:
            print("Connecting: \(peerID.displayName)")
            
        case .notConnected:
            DispatchQueue.main.sync {
                let alert = UIAlertController(title: "Disconnected", message: "\(peerID.displayName) was disconnected.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                present(alert, animated: true)
            }
            
        @unknown default:
            print("Unknown state received: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.sync {
            [weak self] in
            if let image = UIImage(data: data) {
                self?.images.insert(image, at: 0)
                self?.collectionView.reloadData()
                return
            }
            
            let text = String(decoding: data, as: UTF8.self)
            let alert = UIAlertController(title: "Message from \(peerID.displayName)", message: text, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Reply", style: .default) {
                [weak self] _ in
                self?.sendMessageTapped()
            })
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
        }
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        guard let mcSession = mcSession else { return }
        
        let alert = UIAlertController(title: "Connection request", message: "\(peerID.displayName) wants to connect.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Decline", style: .cancel) {
            _ in
            invitationHandler(false, mcSession)
        })
        alert.addAction(UIAlertAction(title: "Accept", style: .default) {
            _ in
            invitationHandler(true, mcSession)
        })
        present(alert, animated: true)
    }
}

