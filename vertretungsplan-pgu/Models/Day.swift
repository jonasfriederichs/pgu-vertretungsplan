//
//  Day.swift
//  vertretungsplan-ui
//
//  Created by Jonas Friederichs on 11.06.23.
//

import Foundation

enum Day: String, Hashable, Codable {
    
    case today = "today"
    case tomorrow = "tomorrow"
    
    var text: String {
        
        switch self {
        case .today: return "Heute"
        case .tomorrow: return "Morgen"
        }
    }
    
}
