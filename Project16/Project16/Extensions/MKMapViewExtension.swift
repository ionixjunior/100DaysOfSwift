import MapKit

extension MKMapView {
    func makeAnnotationView(annotation: MKAnnotation?, reuseIdentifier: String?) -> MKAnnotationView {
        if #available(iOS 11.0, *) {
            return MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        } else {
            return MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }
    }
    
    func changePin(tintColor: UIColor, of annotation: MKAnnotationView?) {
        if #available(iOS 11.0, *) {
            if let annotation = annotation as? MKMarkerAnnotationView {
                annotation.markerTintColor = tintColor
            }
        } else {
            if let annotation = annotation as? MKPinAnnotationView {
                annotation.pinTintColor = tintColor
            }
        }
    }
}
