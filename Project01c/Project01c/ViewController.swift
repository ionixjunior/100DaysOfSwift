import UIKit

class ViewController: UICollectionViewController {
    private var pictures = [Picture]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = UIColor.systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommendTapped))
        performSelector(inBackground: #selector(loadData), with: nil)
    }
    
    @objc func recommendTapped() {
        let viewController = UIActivityViewController(activityItems: ["I liked this app and I believe that you will like too! Please, check this out!"], applicationActivities: [])
        
        if #available(iOS 16.0, *) {
            viewController.popoverPresentationController?.sourceItem = navigationItem.rightBarButtonItem
        } else {
            viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        }
        
        present(viewController, animated: true)
    }
    
    @objc private func loadData() {
        let fileManager = FileManager.default
        let resourcePath = Bundle.main.resourcePath!
        let content = try! fileManager.contentsOfDirectory(atPath: resourcePath)
        pictures = PictureLoader.loadPicturesFrom(content: content)
        collectionView.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: false)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as! PictureCell
        cell.update(name: pictures[indexPath.item].name)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row].name
            vc.currentPicture = pictures[indexPath.row].position
            vc.totalOfPictures = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

