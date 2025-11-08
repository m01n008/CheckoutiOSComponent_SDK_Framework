# 🧩 CheckoutiOSBridge
**Swift + Objective-C Native Framework Integration for Checkout.com SDKs**

CheckoutiOSBridge is a custom-built `.xcframework` that bridges the native Checkout.com payment experience into **Kony/Temenos Infinity** apps using **NFI (Native Function Interface)**.  
It enables seamless in-app payment flows powered by SwiftUI and Checkout’s iOS SDK stack — without requiring additional dependency setup in Visualizer.

---

## 🚀 Key Features
- 🔄 **Native Payment Flow:** Wraps Checkout.com’s `MainView` into a reusable SwiftUI-based flow  
- 🧱 **Single XCFramework:** Bundles all dependencies (CheckoutComponentsSDK, RiskSDK, RememberMe, etc.) inside one `.xcframework`  
- 🧩 **Objective-C Bridge Facade:** Exposes Swift methods (`presentMainAuto`, `pushMain`, `embedMain`) to JavaScript via NFI  
- 🧠 **Thread-Safe Launch:** Supports presentation from the main thread even when triggered via JS  
- ⚙️ **Automated Build Pipeline:** Uses `xcodebuild archive` for both device (arm64) and simulator (arm64) slices  
- 💡 **Configurable Entry Point:** Allows environment or view model injection via `NSDictionary` config  

---

## 🧠 Architecture

Kony Visualizer (JS)
↓ NFI call
CKOBridgeFacade (Objective-C)
↓
CKOBridge (Swift)
↓
SwiftUI MainView → Checkout SDK Components

yaml
Copy code

### Main Components
| Component | Language | Responsibility |
|------------|-----------|----------------|
| **CKOBridge.swift** | Swift | Handles SwiftUI → UIKit bridging and presentation logic |
| **CKOBridgeFacade.h/m** | Objective-C | Exposes public bridge API to Kony’s runtime |
| **MainView.swift** | SwiftUI | Entry point view wrapping Checkout’s SDK |
| **CheckoutiOSComponents.xcframework** | Framework | Bundled binary including all dependencies |

---

## 🏗️ Build Instructions

```bash
# 1️⃣ Build for device (arm64)
xcodebuild archive \
 -scheme CheckoutiOSComponents \
 -destination "generic/platform=iOS" \
 -archivePath build/iphoneos \
 SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# 2️⃣ Build for simulator (arm64)
xcodebuild archive \
 -scheme CheckoutiOSComponents \
 -destination "generic/platform=iOS Simulator" \
 -archivePath build/iphonesimulator \
 SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
 ONLY_ACTIVE_ARCH=YES \
 EXCLUDED_ARCHS="x86_64 i386"

# 3️⃣ Combine into XCFramework
xcodebuild -create-xcframework \
 -framework build/iphoneos.xcarchive/Products/Library/Frameworks/CheckoutiOSComponents.framework \
 -framework build/iphonesimulator.xcarchive/Products/Library/Frameworks/CheckoutiOSComponents.framework \
 -output build/CheckoutiOSComponents.xcframework
🧩 NFI Integration (Kony/Temenos)
config.plist snippet
xml
Copy code
<key>CheckoutiOSComponents</key>
<dict>
    <key>Mode</key>
    <string>XCFWKS</string>
    <key>ThirdPartyBuildHeaders</key>
    <array>
        <string>CheckoutiOSComponents.h</string>
        <string>CKOBridgeFacade.h</string>
    </array>
    <key>ThirdPartyBuildHeadersCommonPath</key>
    <string>/path/to/build/CheckoutiOSComponents.xcframework/ios-arm64/CheckoutiOSComponents.framework/Headers</string>
    <key>ThirdPartyRootDir</key>
    <string>/path/to/build/CheckoutiOSComponents.xcframework</string>
    <key>enabled</key>
    <true/>
</dict>
🔍 Usage (from Kony Visualizer)
javascript
Copy code
define({
  onNavigate: function() {
    this.view.btnOpen.onClick = this.invokeCheckoutIOSNFI;
  },

  invokeCheckoutIOSNFI: function() {
    var bridge = objc.import("CKOBridgeFacade");
    bridge.presentMainAutoAnimated(true);
  }
});
