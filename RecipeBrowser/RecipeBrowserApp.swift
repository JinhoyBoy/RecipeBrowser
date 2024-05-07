//
//  RecipeBrowserApp.swift
//  RecipeBrowser
//
//  Created by Jinho An on 04.05.24.
//

import SwiftUI
import FirebaseCore
import FirebaseDatabase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

@main
struct RecipeBrowserApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        FirebaseApp.configure()
//        Database.database().isPersistenceEnabled = false
    }
    
    @StateObject var selection = Selection()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(selection)
        }
    }
}
