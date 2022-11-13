import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "World"
        
        let london = Capital(coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), title: "London", info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), title: "Oslo", info: "Founded over a thousand years ago.")
        let paris = Capital(coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), title: "Paris", info: "Often called the City of Light.")
        let rome = Capital(coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), title: "Rome", info: "Has a whole country inside it.")
        let washington = Capital(coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), title: "Washington DC", info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Change view", style: .plain, target: self, action: #selector(changeViewTapped))
    }
    
    @objc func changeViewTapped() {
        let alert = UIAlertController(title: "Choose the map type you want to see", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: chooseMapType))
        alert.addAction(UIAlertAction(title: "Hybrid Flyover", style: .default, handler: chooseMapType))
        alert.addAction(UIAlertAction(title: "Muted Standard", style: .default, handler: chooseMapType))
        alert.addAction(UIAlertAction(title: "Satellite", style: .default, handler: chooseMapType))
        alert.addAction(UIAlertAction(title: "Satellite Flyover", style: .default, handler: chooseMapType))
        alert.addAction(UIAlertAction(title: "Standard", style: .default, handler: chooseMapType))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    func chooseMapType(action: UIAlertAction) {
        guard let title = action.title else { return }
        mapView.mapType = getMapTypeFrom(typeName: title)
    }
    
    func getMapTypeFrom(typeName: String) -> MKMapType {
        switch typeName {
        case "Hybrid": return MKMapType.hybrid
        case "Hybrid Flyover": return MKMapType.hybridFlyover
        case "Muted Standard": return MKMapType.mutedStandard
        case "Satellite": return MKMapType.satellite
        case "Satellite Flyover": return MKMapType.satelliteFlyover
        case "Standard": return MKMapType.standard
        default: return MKMapType.standard
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil}
        
        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = mapView.makeAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
        }
        
        mapView.changePin(tintColor: UIColor.purple, of: annotationView)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let placeInfo = capital.info
        
        let alert = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

