# KeyWindow

Convenience functions for magically accessing the key window's safe area and frame from a SwiftUI View

## Usage

```swift
struct MyView: View {
    let phi: CGFloat = 0.61803398875 /// Golden Ratio: https://www.google.com/search?q=golden+ratio
    ScrollView([.horizontal, .verticle]) {
        VStack {
            Text("Hello, world!").foregroundColor(.white)
        }
        .frame(width: keyWindowSafeAreaFrame.width * phi, height: keyWindowSafeAreaFrame.height * phi)
        .background(Color.orange)
        .cornerRadius(10)
    }
}
```

## Discussion

The KeyWindow library is primarily driven by this UIView extension:

```swift
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
```

That is then accessed via a `View` extension:

```swift
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
```

And that's literally all of the code in the repository!

## Installation

### Swift Package Manager

Search for `https://github.com/briannadoubt/KeyWindow` in `Xcode -> File -> Add Packages...` or add the following to the dependancies your `Package.swift` file:

```swift
// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "MySwiftPackage",
    packages: [
        .package(
            name: "KeyWindow",
            url: "https://github.com/briannadoubt/KeyWindow.git",
            .upToNextMajor(from: "0.1.0")
        )
    ],
    targets: [
        .target(
            name: "MySwiftPackage",
            dependencies: [
                .product(
                    name: "KeyWindow",
                    package: "KeyWindow"
                )
            ]
        ),
        .testTarget(
            name: "MySwiftPackageTests",
            dependencies: ["MySwiftPackage"]
        )
    ]
)
```

### Manually

Drag and drop `KeyWindow.swift` into your project and include it in your target build scheme.

