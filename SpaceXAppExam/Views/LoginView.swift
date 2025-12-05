//
//  LoginView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 02/12/2025.
//

import SwiftUI

// Login form for Firebase email/password authentication
struct LoginView: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var isShowingSignUp = false
    @State private var showErrorAlert = false
    @State private var isLoading = false

    @Environment(AuthStateController.self) var authController
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Email", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                        .disabled(isLoading)

                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .disabled(isLoading)
                }

                Section {
                    Button {
                        isLoading = true
                        Task {
                            do {
                                try await authController.signInWithEmailPassword(
                                    email: emailAddress,
                                    password: password
                                )
                                dismiss()
                            } catch {
                                showErrorAlert = true
                            }
                            isLoading = false
                        }
                    } label: {
                        HStack {
                            Spacer()
                            if isLoading {
                                ProgressView()
                            } else {
                                Text("Sign In")
                                    .bold()
                            }
                            Spacer()
                        }
                    }
                    .disabled(
                        isLoading || emailAddress.isEmpty || password.isEmpty
                    )
                }

                Section {
                    Button {
                        isShowingSignUp = true
                    } label: {
                        HStack {
                            Image(systemName: "person.badge.plus")
                            Text("Sign up")
                        }
                    }
                    .disabled(isLoading)
                }
            }
            .navigationTitle("Sign In")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .disabled(isLoading)
                }
            }
        }
        .interactiveDismissDisabled(isLoading)
        .sheet(isPresented: $isShowingSignUp) {
            SignUpView()
                .environment(authController)
        }
        .alert("Login failed", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(authController.errorMessage ?? "Unknown error")
        }
    }
}

#Preview {
    LoginView()
        .environment(AuthStateController())
}
