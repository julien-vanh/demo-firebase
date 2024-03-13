//
//  DemoFirebaseApp.swift
//  DemoFirebase
//
//  Created by Julien Vanheule on 04.02.2024.
//

import SwiftUI
import FirebaseCore

@main
struct DemoFirebaseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authManager: AuthManager
    
    init() {
        FirebaseApp.configure()
        
        let authManager = AuthManager()
        _authManager = StateObject(wrappedValue: authManager)
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(authManager)
        }
    }
}


