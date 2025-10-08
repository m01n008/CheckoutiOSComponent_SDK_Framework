# Device (arm64)
xcodebuild archive \
 -scheme CheckoutiOSComponents \
 -destination "generic/platform=iOS" \
 -archivePath build/iphoneos \
 SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Simulator (arm64 only)
xcodebuild archive \
 -scheme CheckoutiOSComponents \
 -destination "generic/platform=iOS Simulator" \
 -archivePath build/iphonesimulator \
 SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
 ONLY_ACTIVE_ARCH=YES \
 EXCLUDED_ARCHS="x86_64 i386"

xcodebuild -create-xcframework \
 -framework build/iphoneos.xcarchive/Products/Library/Frameworks/CheckoutiOSComponents.framework \
 -framework build/iphonesimulator.xcarchive/Products/Library/Frameworks/CheckoutiOSComponents.framework \
 -output build/CheckoutiOSComponents.xcframework

