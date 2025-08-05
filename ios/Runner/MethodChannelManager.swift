import Foundation
import Flutter

class MethodChannelManager {
    static let shared = MethodChannelManager()

    private var methodChannel: FlutterMethodChannel?
    private var feedbackHandler: ((String) -> Void)?
    private var pendingFeedback: String?  

    private init() {}

    func configure(with messenger: FlutterBinaryMessenger) {
        methodChannel = FlutterMethodChannel(
            name: "com.example.profile/channel",
            binaryMessenger: messenger
        )

        methodChannel?.setMethodCallHandler { [weak self] call, result in
            switch call.method {
            case "sendFeedback":
                if let args = call.arguments as? [String: Any],
                   let message = args["message"] as? String {
                    if let handler = self?.feedbackHandler {
                        handler(message)  
                    } else {
                        self?.pendingFeedback = message  
                    }
                    result(nil)
                } else {
                    result(FlutterMethodNotImplemented)
                }

            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    func sendUserData() {
        guard let channel = methodChannel else {
            return
        }

        let userData: [String: Any] = [
            "name": "Yussif Kahilo",
            "email": "yusufkahilo@icloud.com",
            "image": "profile_pic.png"
        ]

        channel.invokeMethod("userData", arguments: userData)
    }

    func setFeedbackHandler(_ handler: @escaping (String) -> Void) {
        self.feedbackHandler = handler

        if let pending = pendingFeedback {
            handler(pending)
            pendingFeedback = nil
        }
    }
}