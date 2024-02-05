//
//  ContentView.swift
//  DemoFirebase
//
//  Created by Julien Vanheule on 04.02.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack (spacing: 40) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button {
                Task {
                    await sendNotification()
                }
            } label: {
                Text("Envoyer notification locale (10s)")
            }.buttonStyle(BorderedButtonStyle())
        }
        .padding()
    }
    
    func sendNotification() async {
        let content = UNMutableNotificationContent()
        content.title = "Bonjour"
        content.subtitle = "Ceci est une notif locale"
        content.sound = .defaultCritical
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        do {
            try await UNUserNotificationCenter.current().add(request)
        } catch {
            print("Cannot send local notification")
        }
    }
}

#Preview {
    ContentView()
}
