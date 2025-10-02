//
//  String+Capitalizing.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 02/10/25.
//

import Foundation

extension String {
    var capitalizingFirstLetter: String {
        guard let first = first else { return self }
        return String(first).uppercased() + dropFirst()
    }
}

