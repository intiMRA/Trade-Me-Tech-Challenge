//
//  Image+Icons.swift
//  TadeMe
//
//  Created by Inti Albuquerque on 21/01/22.
//

import Foundation
import SwiftUI
enum IconName: String {
    case search = "Search"
    case magnet = "Magnet"
    case profile = "Profile"
    case trolley = "Trolley"
}

extension Image {
    init(iconName: IconName) {
        self.init(iconName.rawValue)
    }
}
