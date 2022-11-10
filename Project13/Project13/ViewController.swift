import UIKit
import CoreImage
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var intensity: UISlider!
    @IBOutlet weak var radius: UISlider!
    @IBOutlet weak var scale: UISlider!
    @IBOutlet weak var center: UISlider!
    @IBOutlet weak var changeFilterButton: UIButton!
    @IBOutlet weak var intensityView: UIView!
    @IBOutlet weak var radiusView: UIView!
    @IBOutlet weak var scaleView: UIView!
    @IBOutlet weak var centerView: UIView!
    
    var currentImage: UIImage!
    var context: CIContext!
    var currentFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Instafilter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        
        resetSliderValues()
        context = CIContext()
        let filterName = "CISepiaTone"
        currentFilter = CIFilter(name: filterName)
        changeButtonFilter(title: filterName)
    }
    
    func resetSliderValues() {
        intensity.value = 0.1
        radius.value = 0.1
        scale.value = 0.1
        center.value = 0.1
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        
        imageView.alpha = 0
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        
        UIView.animate(withDuration: 1, delay: 0) {
            self.imageView.alpha = 1
        }
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
            intensityView.isHidden = false
        } else {
            intensityView.isHidden = true
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(radius.value * 200, forKey: kCIInputRadiusKey)
            radiusView.isHidden = false
        } else {
            radiusView.isHidden = true
        }

        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(scale.value * 10, forKey: kCIInputScaleKey)
            scaleView.isHidden = false
        } else {
            scaleView.isHidden = true
        }

        if inputKeys.contains(kCIInputCenterKey) {
            let x = currentImage.size.width / 2 * CGFloat(center.value)
            let y = currentImage.size.height / 2 * CGFloat(center.value)
            currentFilter.setValue(CIVector(x: x, y: y), forKey: kCIInputCenterKey)
            centerView.isHidden = false
        } else {
            centerView.isHidden = true
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgImage)
            imageView.image = processedImage
        }
    }

    @IBAction func changeFilter(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        alert.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        alert.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        alert.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        alert.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        alert.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        alert.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        present(alert, animated: true)
    }
    
    func setFilter(action: UIAlertAction) {
        guard currentImage != nil else { return }
        guard let filterName = action.title else { return }
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        currentFilter = CIFilter(name: filterName)
        currentFilter.setValue(CIImage(cgImage: cgImage), forKey: kCIInputImageKey)
        resetSliderValues()
        applyProcessing()
        changeButtonFilter(title: filterName)
    }
    
    func changeButtonFilter(title: String) {
        changeFilterButton.setTitle(title, for: .normal)
    }
    
    @IBAction func save(_ sender: Any) {
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        
        if status == PHAuthorizationStatus.denied {
            let alert = UIAlertController(title: "Access denied to your photo library", message: "You need to allow access to the photo library to save your images.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Go to settings", style: .default) {
                _ in
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                UIApplication.shared.open(url)
            })
            alert.addAction(UIAlertAction(title: "Not now", style: .cancel))
            present(alert, animated: true)
        } else {
            guard let image = imageView.image else {
                let alert = UIAlertController(title: "Unable to save image", message: "There are no selected images. You need to choose one to save into the photo library", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                present(alert, animated: true)
                return
            }
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alert = UIAlertController(title: "Unable to save your image", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Saved image", message: "Your image was saved into the photo library.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        }
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        print(sender.value)
        applyProcessing()
    }
}

