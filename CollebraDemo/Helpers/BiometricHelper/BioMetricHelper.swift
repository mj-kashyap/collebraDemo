//
//  BioMetricHelper.swift
//  CollebraDemo
//
//  Created by Manoj Kumar on 19/06/24.
//

import Foundation
import LocalAuthentication

class BiometricAuth {
    
    //MARK: - Biometric authentication helper function
    func authenticateUser(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Access your notes") { success, authenticationError in
                DispatchQueue.main.async {
                    completion(success, authenticationError)
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(false, error)
            }
        }
    }
}

