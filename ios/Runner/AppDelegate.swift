import UIKit
import Flutter

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    var flutterEngine = FlutterEngine(name: "flutter_engine")

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Run Flutter engine
        flutterEngine.run()

        // Register generated plugins
        GeneratedPluginRegistrant.register(with: flutterEngine)

        // Get plugin registrar
        let registrar = flutterEngine.registrar(forPlugin: "com.example.profile")!

        // ✅ Configure MethodChannel early
        MethodChannelManager.shared.configure(with: registrar.messenger())

        // ✅ Register native view
        registrar.register(
            ProfileViewFactory(messenger: registrar.messenger()),
            withId: "profile-view"
        )

        // ✅ Set root FlutterViewController
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = flutterViewController
        self.window?.makeKeyAndVisible()

        return true
    }
}