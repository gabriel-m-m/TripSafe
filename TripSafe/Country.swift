//
//  Country.swift
//  TripSafe
//
//  Created by Gabriel Moosmann Mendez on 2024-02-15.
//

import Foundation
import SwiftData
import TabularData

// @Model
final class Country {
    var name: String
    var police: String?
    var ambulance: String?
    var fire: String?
    var helpline: String?
    var GPI: Double?
    var WPS: Double?
    
    init(name: String, dataRow: DataFrame.Row) {
        self.name = name
        self.police = dataRow["Police"] as? String
        self.ambulance = dataRow["Ambulance"] as? String
        self.fire = dataRow["Fire"] as? String
        self.helpline = dataRow["Helpline"] as? String
        self.GPI = dataRow["GPI"] as? Double
        self.WPS = dataRow["WPS"] as? Double
    }
}
