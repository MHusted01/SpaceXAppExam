//
//  SpaceXAppExamApp.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 01/12/2025.
//

import Firebase
import SwiftUI

// App delegate for Firebase configuration on app launch.
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

// Main entry point for the app. initializes global controllers then injects them into the environment.
@main
struct SpaceXAppExamApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State private var authController = AuthStateController()
    @State private var favoritesController = FavoritesController()

    var body: some Scene {
        WindowGroup {
            LaunchListView()
                .environment(authController)
                .environment(favoritesController)
        }
    }
}
