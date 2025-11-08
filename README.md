This project delivers a complete native bridge (NFI) integration of Checkout.com’s iOS SDK for Kony/Temenos hybrid apps.
The bridge (CKOBridgeFacade) exposes Swift payment flows through Objective-C interfaces, allowing invocation directly from Kony Visualizer JS modules.
The .xcframework package is fully self-contained, embedding all required dependencies (CheckoutComponentsSDK, CheckoutKMPRememberMe, RiskSDK) for both device and simulator architectures.

Key Highlights:

Built reusable Swift wrapper with modular architecture and UIHostingController presentation

Exposed bridge APIs via Objective-C facade for NFI layer

Automated .xcframework generation using xcodebuild archive

Unified simulator + device support (arm64 only)

Integrated inside Kony runtime via config.plist and third-party header mapping
