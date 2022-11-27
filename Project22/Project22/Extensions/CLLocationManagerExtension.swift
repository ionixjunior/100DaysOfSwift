import CoreLocation

extension CLLocationManager {
    func start(uuid: UUID, major: CLBeaconMajorValue, minor: CLBeaconMinorValue, identifier: String) {
        if #available(iOS 13.0, *) {
            let beaconConstraint = CLBeaconIdentityConstraint(uuid: uuid, major: major, minor: minor)
            self.startRangingBeacons(satisfying: beaconConstraint)
        } else {
            let beaconRegion = CLBeaconRegion(uuid: uuid, major: major, minor: minor, identifier: identifier)
            self.startMonitoring(for: beaconRegion)
            self.startRangingBeacons(in: beaconRegion)
        }
    }
}
