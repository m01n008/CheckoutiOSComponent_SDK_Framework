//
//  CKOBridge.swift
//  CheckoutiOSComponents
//
//  Created by Moin Khan on 07/10/2025.
//

import Foundation
import SwiftUI
import UIKit

@MainActor                      
@objcMembers
public final class CKOBridge: NSObject {

    /// Create a UIViewController hosting your SwiftUI MainView.
    public static func makeMainViewController() -> UIViewController {
        assert(Thread.isMainThread) // dev guard; remove if you prefer
        let hosting = UIHostingController(rootView: MainView())
        hosting.title = "Checkout"
        return hosting
    }

    /// Present modally from the current top-most VC.
    public static func presentMainAuto(animated: Bool = true, config: NSDictionary? = nil) {
        let vc = makeConfiguredMainVC(config: config)
        let nav = UINavigationController(rootViewController: vc)
        guard let presenter = topMostViewController() else { return }
        // If something is already presented, present from that controller to avoid warnings.
        (presenter.presentedViewController ?? presenter).present(nav, animated: animated)
    }

    /// Push onto an existing navigation stack.
    public static func pushMain(on navigationController: UINavigationController,
                                animated: Bool = true,
                                config: NSDictionary? = nil) {
        let vc = makeConfiguredMainVC(config: config)
        navigationController.pushViewController(vc, animated: animated)
    }

    /// Embed inside a container view managed by `parent`.
    public static func embedMain(in containerView: UIView,
                                 parentViewController parent: UIViewController,
                                 config: NSDictionary? = nil) {
        let child = makeConfiguredMainVC(config: config)
        parent.addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(child.view)
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            child.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
        child.didMove(toParent: parent)
    }

    // MARK: - Config/thread-safe helpers

    private static func makeConfiguredMainVC(config: NSDictionary?) -> UIViewController {
        assert(Thread.isMainThread) // dev guard
        // Example: read config and inject into the SwiftUI view if needed.
        // let publicKey = config?["publicKey"] as? String ?? ""
        // let vm = CheckoutViewModel(publicKey: publicKey)
        // let view = MainView().environmentObject(vm)
        let view = MainView()
        return UIHostingController(rootView: view)
    }

    /// Safely finds the top-most visible view controller.
    private static func topMostViewController(from base: UIViewController? = {
        // Use keyWindow on iOS 15+ via connectedScenes
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .rootViewController
    }()) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topMostViewController(from: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topMostViewController(from: selected)
        }
        if let presented = base?.presentedViewController {
            return topMostViewController(from: presented)
        }
        return base
    }
}

