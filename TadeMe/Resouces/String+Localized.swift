//
//  String+Localized.swift
//  TadeMe
//
//  Created by Inti Albuquerque on 25/01/22.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
