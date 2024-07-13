//
//  SceneDelegate.swift
//  Organizer
//
//  Created by Feruza Yuldasheva on 7/11/24.
//
import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow 'window' to the provided UIWindowScene 'scene'.
        // If using a storyboard, the 'window' property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see 'application: configurationForConnectingSceneSession' instead).
        
        // Get the managed object context from the shared persistent container.
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Create the SwiftUI view and set the context as an environment value.
        let contentView = ContentView().environment(\.managedObjectContext, context).environmentObject(IconNames())
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

//


//MARK: - ALTERNATIVE ICONS

//something here wrong going

class IconNames: ObservableObject {
    @Published var iconNames: [String?] = [nil]
    @Published var currentIndex = 0
    
    init() {
        getAlternateIconNames()
        if let currentIcon = UIApplication.shared.alternateIconName {
            self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
        }
    }
    
    func getAlternateIconNames() {
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
           let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any] {
            for (_, value) in alternateIcons {
                guard let iconList = value as? [String: Any],
                      let iconFiles = iconList["CFBundleIconFiles"] as? [String],
                      let icon = iconFiles.first else {
                    continue
                }
                iconNames.append(icon)
            }
        }
    }
}
