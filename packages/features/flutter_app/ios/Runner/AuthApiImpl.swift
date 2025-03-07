//
//  AuthApiImpl.swift
//  Runner
//
//  Created by Jackson Cuevas on 7/3/25.
//

import LocalAuthentication

class AuthApiImpl: AuthApi {
    func authenticate(completion: @escaping (Result<AuthResult, Error>) -> Void) {
        DispatchQueue.main.async {
            let context = LAContext()
            var error: NSError?
            
            // Definir política de autenticación (Face ID, Touch ID o código de acceso)
            let policy: LAPolicy = .deviceOwnerAuthentication
            
            // Verificar si Face ID, Touch ID o código de acceso están disponibles
            guard context.canEvaluatePolicy(policy, error: &error) else {
                completion(.failure(error ?? NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Authentication not available"])))
                return
            }
            
            // Intentar autenticación con Face ID, Touch ID o PIN
            context.evaluatePolicy(policy, localizedReason: "Use Face ID, Touch ID, or passcode to authenticate") { success, evalError in
                if success {
                    completion(.success(AuthResult(success: true, message: "Authentication succeeded")))
                } else {
                    let errorMessage = evalError?.localizedDescription ?? "Authentication failed"
                    completion(.failure(NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                }
            }
        }
    }
}

