import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // TODO: Add your API key
    GMSServices.provideAPIKey("AIzaSyBkSl2tqi-5P8rmTlrVCAVxvITU9MAGeFw")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
