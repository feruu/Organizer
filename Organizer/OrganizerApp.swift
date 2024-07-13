//
//  OrganizerApp.swift
//  Organizer
//
//  Created by Feruza Yuldasheva on 6/29/24.
//

import SwiftUI

@main
struct OrganizerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var iconNames = IconNames()

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(iconNames)
        }
    }
}
