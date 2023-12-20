//
//  Sight.swift
//  iTour-v2
//
//  Created by Allan Tweddle on 20/12/2023.
//

import Foundation
import SwiftData

@Model
class Sight {
    var name: String
    var destination: Destination?

    init(name: String) {
        self.name = name
    }
}

