
import SwiftUI

public extension UIView {
    static func keyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }
}

public extension View {

    var keyWindowSafeAreaFrame: CGRect {
        let safeAreaInsets = UIView.keyWindow()?.safeAreaInsets ?? .zero
        let frame = keyWindowFrame.inset(by: safeAreaInsets)
        return frame
    }

    var keyWindowTopSafeArea: CGFloat {
        let safeAreaInsets = UIView.keyWindow()?.safeAreaInsets ?? .zero
        return safeAreaInsets.top
    }
    
    var keyWindowBottomSafeArea: CGFloat {
        let safeAreaInsets = UIView.keyWindow()?.safeAreaInsets ?? .zero
        return safeAreaInsets.bottom
    }

    var keyWindowFrame: CGRect {
        UIScreen.main.bounds
    }
}

public struct DeviceRotationViewModifier: ViewModifier {
    public let action: (UIDeviceOrientation) -> Void

    public func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

public extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
