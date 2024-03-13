//
//  LoginView.swift
//  DemoFirebase
//
//  Created by Julien Vanheule on 12/03/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager
    @ObservedObject private var viewModel = LoginViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                TextField("Email", text: $viewModel.userEmail)
                    .keyboardType(.emailAddress)
                    .customTextField(icon: "person")
                SecureField("Password", text: $viewModel.userPassword)
                    .customTextField(icon: "lock")
                Button(action: login, label: {
                    Text("Se connecter")
                })
                .disabled(!viewModel.formIsValid)
                if(!errorMessage.isEmpty) {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
                Spacer()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .navigationTitle("Login")
        }
    }
    
    func login() {
        errorMessage = ""
        authManager.login(email: self.viewModel.userEmail, password: self.viewModel.userPassword) { result in
            switch result {
            case .failure(let error):
                errorMessage = error.localizedDescription
            case .success(_):
                dismiss()
            }
        }
    }
}

#Preview {
    LoginView()
}
