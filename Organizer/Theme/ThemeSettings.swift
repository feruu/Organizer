//
//  ThemeSettings.swift
//  Organizer
//
//  Created by Feruza Yuldasheva on 7/12/24.
//

import SwiftUI

//MARK: - THEME Class

class ThemeSettings: ObservableObject {
    @Published var themeSettings : Int = UserDefaults.standard.integer(forKey: "Theme"){
        didSet{
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
}
