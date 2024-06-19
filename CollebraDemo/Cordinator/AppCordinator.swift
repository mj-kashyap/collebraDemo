//
//  AppCordinator.swift
//  CollebraDemo
//
//  Created by Manoj Kumar on 19/06/24.
//

import Foundation
import SwiftUI
import LocalAuthentication

class AppCoordinator: ObservableObject {
    @Published var isAuthenticated: Bool = false
    private let biometricAuth = BiometricAuth()

    func start() {
        biometricAuth.authenticateUser { [weak self] success, error in
            if success {
                self?.isAuthenticated = true
            } else {
                self?.showAuthenticationFailedAlert(error: error)
            }
        }
    }

    private func showAuthenticationFailedAlert(error: Error?) {
        // Handle authentication failure (e.g., update a state variable to show an error message)
        // For now, we'll just print the error
        print("Authentication failed: \(error?.localizedDescription ?? "Unknown error")")
    }
}
