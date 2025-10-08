#!/bin/bash
set -e

# Clean previous build output
rm -rf build

# --------------------------
# Build for iOS (physical device)
# --------------------------
xcodebuild archive \
  -scheme CheckoutiOSComponents \
  -destination "generic/platform=iOS" \
  -archivePath build/iphoneos.xcarchive \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  EXCLUDED_ARCHS="x86_64 i386"

# --------------------------
# Build for iOS Simulator (Apple Silicon only)
# --------------------------
xcodebuild archive \
  -scheme CheckoutiOSComponents \
  -destination "generic/platform=iOS Simulator" \
  -archivePath build/iphonesimulator.xcarchive \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  EXCLUDED_ARCHS="x86_64 i386" \
  ARCHS="arm64"

# --------------------------
# Create XCFramework (arm64 only)
# --------------------------
xcodebuild -create-xcframework \
  -framework build/iphoneos.xcarchive/Products/Library/Frameworks/CheckoutiOSComponents.framework \
  -framework build/iphonesimulator.xcarchive/Products/Library/Frameworks/CheckoutiOSComponents.framework \
  -output build/CheckoutiOSComponents.xcframework

echo "Apple-Silicon-only XCFramework created at: build/CheckoutiOSComponents.xcframework"

