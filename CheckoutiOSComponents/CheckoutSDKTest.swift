//
//  CheckoutiOSComponentVerify.swift
//  CheckoutiOSComponents
//
//  Created by Moin Khan on 03/10/2025.
//
import CheckoutComponentsSDK
import Foundation
import SwiftUI

@objc public class CheckoutSDKTest: NSObject {

    var checkoutComponentsView: AnyView?

    var showPaymentResult: Bool = false
    var paymentSucceeded: Bool = true
    var paymentResultText: String = ""
    var generatedToken: String = ""
    var errorMessage: String = ""
    var showCardPayButton: Bool = true
    var paymentButtonAction: CheckoutComponents.PaymentButtonAction = .payment
    var selectedComponentType: CheckoutComponent = .flow
    var selectedPaymentMethodTypes: Set<PaymentMethodType> = []
    var selectedLocale: String = CheckoutComponents.Locale.en_GB.rawValue
    var selectedEnvironment: CheckoutComponents.Environment = .sandbox
    var selectedAddressConfiguration: AddressComponentConfiguration = .prefillCustomized
    var handleSubmitManually = false
    var updatedAmount = ""
    var isShowUpdateView = false
    var showApplePayButton: Bool = true
    var isAdvancedFeaturesExpanded: Bool = false
    var customButtonOperation: CustomButtonOperation = .submitPayment

    var isRememberMeExpanded: Bool = false
    var userEmail: String = ""
    var userPhoneNumber: String = ""
    var userCountryCode: String = ""
    var showRememberMe: Bool = true
    var showRememberMePayButton: Bool = true
    var paymentSessionId = ""

    var isDefaultAppearance = true

    @objc public func testPaymentSessionRequest() async {
        // Replace with your sandbox credentials from Checkout.com dashboard
        let processingChannelID = "pc_chqnq3qhsvgu5iftre3jirjjnm"
        let publicKey = "pk_sbox_os7rnagpspvropvvbontalad4ul"
        let secretKey = "sk_sbox_dnhbpeusmh4bq3rhzhx3uqjhwms" // (demo only; use backend in prod)

        // Create a PaymentSessionRequest (model for session creation)
        let paymentSessionRequest = PaymentSessionRequest(
            amount: 1,
            currency: "GBP",
            billing: .init(address: .init(country: "GB")),
            successURL: Constants.successURL,
            failureURL: Constants.failureURL,
            threeDS: .init(enabled: true, attemptN3D: true),
            processingChannelID: EnvironmentVars.processingChannelID
        )

        do {
            // 1) Build a PaymentSession from your request (no Decoder casts!)
            let paymentSession = try await PaymentSession(from: paymentSessionRequest as! Decoder)

            // 2) Prepare callbacks (non-throwing)
            let callbacks = dummy()

            // 3) Now build the configuration
            let config = try await CheckoutComponents.Configuration(
                paymentSession: paymentSession,
                publicKey: publicKey,
                environment: .sandbox,
                callbacks: callbacks
            )

            // 4) Use/keep references as needed
            paymentSessionId = paymentSessionRequest.processingChannelID ?? "unknown"
            print("Configuration initialized: \(publicKey)")
            print("PaymentSessionRequest created with channel ID: \(paymentSessionRequest.processingChannelID ?? "nil"), amount: \(paymentSessionRequest.amount)")

            // Example async call to create session (requires secret key; do on backend in prod)
            /*
            let apiClient = CheckoutAPIClient(secretKey: secretKey, environment: .sandbox)
            apiClient.createPaymentSession(
                request: paymentSessionRequest
            ) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let paymentSession):
                        print("Payment session created successfully: \(paymentSession.sessionId)")
                        let components = CheckoutComponentsFactory.makeCheckoutComponents(
                            configuration: config,
                            paymentSession: paymentSession
                        )
                        // render components...
                    case .failure(let error):
                        print("Error creating payment session: \(error.localizedDescription)")
                    }
                }
            }
            */

        } catch {
            print("Error during SDK test: \(error.localizedDescription)")
        }
    }

    // Keep this NON-throwing and match the SDK’s expected signatures.
    func dummy() -> CheckoutComponents.Callbacks {
        return CheckoutComponents.Callbacks(
            // If your SDK’s onSuccess is (Describable, PaymentID) -> Void:
            onSuccess: { paymentMethod, paymentID in
                print("Success: \(paymentMethod.name) -> \(paymentID)")
            },
            onError: { error in
                print("Error: \(error)")
            }
        )
    }

    // --- Your commented advanced callbacks and helpers can stay as-is below ---
    // (left unchanged)
}
