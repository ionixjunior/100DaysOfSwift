import UIKit
import AVFoundation

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var people = [Person]()
    let peopleKey = "people"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPersonTapped))
        
        do {
            if let data = UserDefaults.standard.object(forKey: peopleKey) as? Data {
                people = try JSONDecoder().decode([Person].self, from: data)
            }
        } catch {
            print("Failed to load people")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else { fatalError("Unable to dequeue PersonCell") }
        
        let person = people[indexPath.item]
        let name = person.name
        let path = getDocumentsDirectory().appending(path: person.image)
        let image = path.getPath()
        cell.update(name: name, image: image)
        cell.addBorders()
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = self.people[indexPath.item]
        
        let alert = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Rename", style: .default) {
            [weak self] _ in
            self?.rename(person: person, at: indexPath)
        })
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) {
            [weak self] _ in
            self?.delete(person: person, at: indexPath)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    private func rename(person: Person, at indexPath: IndexPath) {
        let alert = UIAlertController(title: "Type a name", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Ok", style: .default) {
            [weak self, weak alert] _ in
            if let name = alert?.textFields?.first?.text {
                person.name = name
                self?.collectionView.reloadItems(at: [indexPath])
                self?.save()
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    private func delete(person: Person, at indexPath: IndexPath) {
        people.remove(at: indexPath.item)
        collectionView.deleteItems(at: [indexPath])
        save()
    }
    
    @objc func addPersonTapped() {
        if UIImagePickerController .isSourceTypeAvailable(.camera) {
            let alert = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default) {
                [weak self] _ in
                self?.pickFromCamera()
            })
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default) {
                [weak self] _ in
                self?.pickFromPhotoLibrary()
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
        } else {
            pickFromPhotoLibrary()
        }
    }
    
    private func pickFromCamera() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
            return
        }
        
        let alert = UIAlertController(title: "Please, allow camera access", message: "You need to allow camera access to use this feature. Go to settings and allow it.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Go to settings", style: .default) {
            _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    private func pickFromPhotoLibrary() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appending(path: imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.5) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        save()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager().urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(people)
            UserDefaults.standard.set(data, forKey: peopleKey)
        } catch {
            print("Failed to save people")
        }
    }
}

