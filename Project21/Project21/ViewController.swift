import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) {
            granted, error in
            if granted {
                print("Permission granted")
            } else {
                print("Permission denied")
            }
        }
    }
    
    @objc func scheduleLocal() {
        registerCategories()
        
        let content = UNMutableNotificationContent()
        content.title = "Lorem notification"
        content.body = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ut nisl sapien."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "test"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let ignore = UNNotificationAction(identifier: "ignore", title: "Ignore", options: .destructive)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, ignore], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                let alert = UIAlertController(title: "Default identifider", message: "The custom data is \(customData)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                present(alert, animated: true)
            case "show":
                let alert = UIAlertController(title: "Show identifider", message: "The custom data is \(customData)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                present(alert, animated: true)
            case "ignore":
                print("ignore identifier")
            default:
                break
            }
        }
        
        completionHandler()
    }
}

