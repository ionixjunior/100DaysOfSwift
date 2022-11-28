import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var distanceReading: UILabel!
    @IBOutlet weak var beaconName: UILabel!
    @IBOutlet weak var distanceView: UIView!
    
    var locationManager: CLLocationManager?
    var beacons: [(uuidString: String, major: CLBeaconMajorValue, minor: CLBeaconMajorValue, identifier: String)] = [
        (uuidString: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", major: 123, minor: 456, identifier: "Left Beacon"),
        (uuidString: "92AB49BE-4127-42F4-B532-90FAF1E26491", major: 101, minor: 200, identifier: "Right Beacon")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        distanceReading.text = "UNKNOWN"
        beaconName.text = ""
        distanceView.layer.cornerRadius = 128
        distanceView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
    }
    
    // legacy method implementation
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }

    // new method implementation
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        for beacon in beacons {
            guard let uuid = UUID(uuidString: beacon.uuidString) else { return }
            locationManager?.start(uuid: uuid, major: beacon.major, minor: beacon.minor, identifier: beacon.identifier)
        }
    }
    
    func update(distance: CLProximity, identifier: String) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReading.text = "FAR"
                self.beaconName.text = identifier
                self.distanceView.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReading.text = "NEAR"
                self.beaconName.text = identifier
                self.distanceView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                
            case .immediate:
                self.view.backgroundColor = .red
                self.distanceReading.text = "RIGHT HERE"
                self.beaconName.text = identifier
                self.distanceView.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "UNKNOWN"
                self.beaconName.text = ""
                self.distanceView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            let beaconIdentifier = self.beacons.first(where: { $0.uuidString == beacon.uuid.uuidString })?.identifier ?? ""
            update(distance: beacon.proximity, identifier: beaconIdentifier)
        }
    }
}

