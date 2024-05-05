//
//  RecipeBrowserApp.swift
//  RecipeBrowser
//
//  Created by Jinho An on 04.05.24.
//

import SwiftUI
import FirebaseCore

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
    }
    
    @StateObject var selection = Selection()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(selection)
        }
    }
}
