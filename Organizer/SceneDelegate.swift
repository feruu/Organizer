//
//  SceneDelegate.swift
//  Organizer
//
//  Created by Feruza Yuldasheva on 7/11/24.
//

import Foundation
import UIKit
import SwiftUI


class SceneDelegate: UIResponder, UIWebViewDelegate{
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, option connectionOptions: UIScene.ConnectionOptions){
        //Use this method to optionally configure and attach the UIWindow 'window' to the provided UIWindowScene 'scene'.
        //If using a storyboard, the 'window' property will automatically be initialized and attached to the scene.
        //This delegete does not imply the connecting scene or session are new (see 'application: configurationForConnectingSceneSession' instead
        //Get the managed object context from the shared persistent container.
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let contentView = ContentView().environment(\.managedObjectContext, context)
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView.environmentObject(IconNames()))
            self.window = window
            window.makeKeyAndVisible()
        }

    }
}
//

//let contentView = ContentView().environment(\.managedOb)
//MARK: - ALTERNATIVE ICONS

class IconNames: ObservableObject {
    var iconNames: [String?] = [nil]
    @Published var currentIndex = 0
    init(){
        getAlternateIconNames()
        if let currentIcon = UIApplication.shared.alternateIconName {
            self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
        }
    }
    func getAlternateIconNames(){
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any], let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any]{
            for (_, value) in alternateIcons{
                guard let iconList = value as? Dictionary<String, Any> else { return }
                guard let iconFiles = iconList["CFBundleIconFiles"] as? [String] else { return }
                guard let icon = iconFiles.first else { return }
                
                iconNames.append(icon)
            }
        }
    }
}
