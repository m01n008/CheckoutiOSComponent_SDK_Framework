//  Copyright © 2025 Checkout.com. All rights reserved.

import SwiftUI

@MainActor
struct NavigationHelper {
  static func navigationBarTitleTextColor(_ color: Color) {
    let uiColor = UIColor(color)
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
  }
}
