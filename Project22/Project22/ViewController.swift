import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var distanceReading: UILabel!
    @IBOutlet weak var beaconName: UILabel!
    
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        guard let uuid = UUID(uuidString: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6") else { return }
        locationManager?.start(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReading.text = "FAR"
                
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReading.text = "NEAR"
                
            case .immediate:
                self.view.backgroundColor = .red
                self.distanceReading.text = "RIGHT HERE"
                
            default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "UNKNOWN"
            }
        }
    }
    
    var lastBeacon: UUID?
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            if lastBeacon == nil {
                let alert = UIAlertController(title: "New beacon detected", message: "You are nearby a beacon!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                present(alert, animated: true)
            }
            
            lastBeacon = beacon.uuid
            update(distance: beacon.proximity)
        } else {
            lastBeacon = nil
            update(distance: .unknown)
        }
    }
}

