//
//  HomeView.swift
//  DemoFirebase
//
//  Created by Julien Vanheule on 12/03/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var showLoginSheet = false
    @State private var showAccountSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                Button {
                    Task {
                        await NotificationManager.sendNotification()
                    }
                } label: {
                    Text("Envoyer notification locale (3s)")
                }
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    if authManager.authState == .signedIn {
                        Button(action: {
                            showAccountSheet.toggle()
                        }, label: {
                            DefaultAvatar()
                        })
                    }
                    else {
                        Button(action: {
                            showLoginSheet.toggle()
                        }, label: {
                            Text("Se connecter")
                        })
                    }
                }
            }
        }.sheet(isPresented: $showLoginSheet) {
            LoginView()
        }.sheet(isPresented: $showAccountSheet) {
            AccountView()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthManager())
}
