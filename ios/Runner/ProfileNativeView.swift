import Flutter
import SwiftUI

class ProfileNativeView: NSObject, FlutterPlatformView {
    private var containerView: UIView

    init(frame: CGRect, viewId: Int64, messenger: FlutterBinaryMessenger) {
        containerView = UIView(frame: frame)
        super.init()

        MethodChannelManager.shared.configure(with: messenger)

        let swiftUIView = ProfileView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(hostingController.view)

        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

    func view() -> UIView {
        return containerView
    }
}