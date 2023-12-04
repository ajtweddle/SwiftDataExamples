//
//  Sight.swift
//  iTour
//
//  Created by Allan Tweddle on 17/11/2023.
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
