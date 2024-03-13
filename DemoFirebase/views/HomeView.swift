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
    
    var body: some View {
        VStack(alignment: .leading) {
            if authManager.authState == .signedIn {
                Text(authManager.user?.displayName ?? "Name placeholder")
                    .font(.headline)
                Text(authManager.user?.email ?? "Email placeholder")
                    .font(.subheadline)
                Button(action: logout, label: {
                    Text("Se déconnecter")
                })
            }
            else {
                Button(action: {
                    showLoginSheet.toggle()
                }, label: {
                    Text("Se connecter")
                })
            }
            
            Button {
                Task {
                    await sendNotification()
                }
            } label: {
                Text("Envoyer notification locale (3s)")
            }.buttonStyle(BorderedButtonStyle())
        }.sheet(isPresented: $showLoginSheet) {
            LoginView()
        }
    }
    
    func sendNotification() async {
        let content = UNMutableNotificationContent()
        content.title = "Bonjour"
        content.subtitle = "Ceci est une notif locale"
        content.sound = .defaultCritical
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        do {
            try await UNUserNotificationCenter.current().add(request)
        } catch {
            print("Cannot send local notification")
        }
    }
    
    func logout() {
        do {
            try authManager.logout()
        }
        catch {
            print("Error: \(error)")
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthManager())
}
