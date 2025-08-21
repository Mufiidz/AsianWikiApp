import Flutter
import UIKit
import flutter_local_notifications
import workmanager_apple

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FlutterLocalNotificationsPlugin
            .setPluginRegistrantCallback { (registry) in
                GeneratedPluginRegistrant.register(with: registry)
            }
        
        //        if #available(iOS 10.0, *) {
        //            UNUserNotificationCenter
        //                .current().delegate = self as? UNUserNotificationCenterDelegate
        //        }
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted for debug handler")
            } else if let error = error {
                print("Error requesting notification permission: \(error)")
            }
        }
        
        WorkmanagerPlugin.setPluginRegistrantCallback { registry in
            // Registry in this case is the FlutterEngine that is created in Workmanager's
            // performFetchWithCompletionHandler or BGAppRefreshTask.
            // This will make other plugins available during a background operation.
            GeneratedPluginRegistrant.register(with: registry)
        }
        
        // EXAMPLE: Enable debug notifications for background tasks
        // Uncomment one of the following lines to enable debug output:
        
        // Option 1: Notification-based debug handler (shows debug info as notifications)
        // WorkmanagerDebug.setCurrent(NotificationDebugHandler())
        
        // Option 2: Logging-based debug handler (writes to system log)
        // WorkmanagerDebug.setCurrent(LoggingDebugHandler())
        
        // WorkmanagerPlugin
        //     .registerBGProcessingTask(
        //         withIdentifier: "id.my.mufidz.asianwiki.initial"
        //     )
        // Register a periodic task in iOS 13+
        WorkmanagerPlugin
            .registerPeriodicTask(
                withIdentifier: "id.my.mufidz.asianwiki.iOSBackgroundAppRefresh",
                frequency: NSNumber(value: 20 * 60)
            )
        GeneratedPluginRegistrant.register(with: self)
        return super.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
    }
}
