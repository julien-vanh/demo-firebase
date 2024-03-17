//
//  AccountView.swift
//  DemoFirebase
//
//  Created by Julien Vanheule on 17/03/2024.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.dismiss) private var dismiss
    @State private var showingAlert = false
    @State private var name = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button(action: {
                        showingAlert.toggle()
                    }, label: {
                        VStack(alignment: .leading) {
                            Text(authManager.user?.displayName ?? "Username")
                                .font(.headline)
                                .foregroundColor(.accentColor)
                            Text(authManager.user?.email ?? "Email")
                                .font(.subheadline)
                        }
                    })
                    .buttonStyle(PlainButtonStyle())
                    .alert("Modifier le nom", isPresented: $showingAlert) {
                        TextField("Nouveau nom", text: $name)
                        Button("OK", action: submit)
                    }
                }
                Section {
                    Button(action: logout, label: {
                        Text("Se déconnecter")
                    })
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Compte")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button("Terminé") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func submit() {
        Task {
            do {
                guard name.count > 0 else {
                    return
                }
                try await authManager.updateUser(displayName: name)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func logout() {
        do {
            try authManager.logout()
            dismiss()
        }
        catch {
            print("Error: \(error)")
        }
    }
}

#Preview {
    AccountView()
        .environmentObject(AuthManager())
}
