
import SwiftUI

#if canImport(AppKit)
public extension View {
    var safeAreaInsets: NSEdgeInsets {
        NSApplication.shared.keyWindow?.contentView?.safeAreaInsets ?? NSEdgeInsets()
    }
    
    var keyWindowFrame: CGRect {
        NSApplication.shared.keyWindow?.frame ?? .zero
    }

    var keyWindowSafeAreaFrame: CGRect {
        let frame = keyWindowFrame.insetBy(dx: safeAreaInsets.left + safeAreaInsets.right, dy: safeAreaInsets.top + safeAreaInsets.bottom)
        return frame
    }

    var keyWindowTopSafeArea: CGFloat {
        return safeAreaInsets.top
    }
    
    var keyWindowBottomSafeArea: CGFloat {
        return safeAreaInsets.bottom
    }
}
#endif

#if canImport(UIKit)
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
    var safeAreaInsets: UIEdgeInsets {
        UIView.keyWindow()?.safeAreaInsets ?? .zero
    }
    
    var keyWindowFrame: CGRect {
        UIScreen.main.bounds
    }

    var keyWindowSafeAreaFrame: CGRect {
        let frame = keyWindowFrame.inset(by: safeAreaInsets)
        return frame
    }

    var keyWindowTopSafeArea: CGFloat {
        return safeAreaInsets.top
    }
    
    var keyWindowBottomSafeArea: CGFloat {
        return safeAreaInsets.bottom
    }
}
#endif
