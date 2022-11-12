import MapKit

extension MKMapView {
    func makeAnnotationView(annotation: MKAnnotation?, reuseIdentifier: String?) -> MKAnnotationView {
        if #available(iOS 11.0, *) {
            return MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        } else {
            return MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }
    }
}
