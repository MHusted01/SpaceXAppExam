//
//  SignUpView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 02/12/2025.
//

import SwiftUI

// Sign up form for creating new Firebase accounts.
struct SignUpView: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""
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
                                try await authController.signUpWithEmailPassword(
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
                                Text("Sign Up")
                                    .bold()
                            }
                            Spacer()
                        }
                    }
                    .disabled(isLoading || emailAddress.isEmpty || password.isEmpty)
                }
            }
            .navigationTitle("Sign Up")
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
        .alert("Sign up failed", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(authController.errorMessage ?? "Unknown error")
        }
    }
}

#Preview {
    SignUpView()
        .environment(AuthStateController())
}
