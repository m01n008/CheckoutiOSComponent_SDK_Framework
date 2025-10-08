//
//  Untitled.swift
//  CheckoutiOSComponents
//
//  Created by Moin Khan on 03/10/2025.
//
import Foundation
import CheckoutiOSComponents

@objc public class TestRunner: NSObject {
    @objc public static func runCheckoutSDKTest() async {
        let tester = CheckoutSDKTest()
        await tester.testPaymentSessionRequest()
    }
}
