//
//  Destination.swift
//  iTour
//
//  Created by Allan Tweddle on 15/11/2023.
//

import Foundation
import SwiftData

@Model
class Destination {
    var name: String
    var details: String
    var date: Date
    var priority: Int
    @Attribute(.externalStorage) var image: Data?
    @Relationship(deleteRule: .cascade, inverse: \Sight.destination) var sights = [Sight]()

    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 2) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}
