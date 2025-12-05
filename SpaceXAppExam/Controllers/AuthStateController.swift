//
//  AuthStateController.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 02/12/2025.
//

import FirebaseAuth
import FirebaseCore
import Foundation
import Observation

// Controller for Firebase authentication state and operations.
// Manages sign in, sign up, sign out and auth state listening.
@Observable
class AuthStateController {

    enum AuthenticationState {
        case unauthenticated
        case authenticated
    }

    var authenticationState: AuthenticationState = .unauthenticated
    var user: User?
    var displayName: String = ""
    var errorMessage: String?

    private var authStateHandler: AuthStateDidChangeListenerHandle?

    init() {
        if FirebaseApp.app() != nil {
            registerAuthStateHandler()
        } else {
            authenticationState = .unauthenticated
            user = nil
            displayName = ""
        }
    }

    /// Registers a listener for Firebase auth state changes.
    func registerAuthStateHandler() {
        guard authStateHandler == nil else { return }

        authStateHandler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self else { return }

            self.user = user
            self.authenticationState = (user == nil) ? .unauthenticated : .authenticated
            self.displayName = user?.email ?? ""
        }
    }

    /// Converts Firebase auth errors to user-friendly messages.
    /// - Parameter error: The Firebase error.
    /// - Returns: A localized error message string.
    private func handleAuthError(_ error: Error) -> String {
        let nsError = error as NSError
        guard let errorCode = AuthErrorCode(rawValue: nsError.code) else {
            return error.localizedDescription
        }
        
        switch errorCode {
        case .invalidEmail:
            return "Invalid email address"
        case .wrongPassword:
            return "Incorrect password"
        case .userNotFound:
            return "No account found with this email"
        case .emailAlreadyInUse:
            return "Email is already registered"
        case .weakPassword:
            return "Password must be at least 6 characters"
        case .networkError:
            return "Network error. Check your connection"
        case .tooManyRequests:
            return "Too many attempts. Try again later"
        default:
            return error.localizedDescription
        }
    }

    /// Signs in with email and password.
    /// - Parameters: email: User's email address. password: User's password.
    /// - Throws: Firebase auth error if sign in fails.
    func signInWithEmailPassword(email: String, password: String) async throws {
        errorMessage = nil
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)

            if FirebaseApp.app() != nil {
                registerAuthStateHandler()
            }
        } catch {
            errorMessage = handleAuthError(error)
            throw error
        }
    }

    /// Creates a new account with email and password.
    /// - Parameters: email: User's email address. password: User's password.
    /// - Throws: Firebase auth error if sign up fails.
    func signUpWithEmailPassword(email: String, password: String) async throws {
        errorMessage = nil
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            
            if FirebaseApp.app() != nil {
                registerAuthStateHandler()
            }
        } catch {
            errorMessage = handleAuthError(error)
            throw error
        }
    }

    /// Signs out the current user.
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            errorMessage = "Could not sign out"
        }
    }

    deinit {
        if let handler = authStateHandler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }
}
