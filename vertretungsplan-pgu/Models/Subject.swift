//
//  Icons.swift
//  vertretungsplan-ui
//
//  Created by Jonas Friederichs on 11.06.23.
//

import Foundation
import SwiftUI

enum Subject: String, Hashable, Codable {
    
    case german
    case maths
    case english
    
    case physics
    case biology
    case chemistry
    case computerScience
    
    case politics
    case geography
    case philosophy
    case history
    case katholicReligion
    case protestantReligion
    
    case music
    case art
    
    case latin
    case french
    case spanish
    
    case sports
    
    var name: String {
        
        switch self {
            
        case .german: return "Deutsch"
        case .maths: return "Mathematik"
        case .english: return "Englisch"
            
        case .physics: return "Physik"
        case .biology: return "Biologie"
        case .chemistry: return "Chemie"
        case .computerScience: return "Informatik"
            
        case .politics: return "Politik"
        case .geography: return "Erdkunde"
        case .philosophy: return "Philosophie"
        case .history: return "Geschichte"
        case .katholicReligion: return "kath. Religion"
        case .protestantReligion: return "ev. Religion"
            
        case .music: return "Musik"
        case .art: return "Kunst"
            
        case .latin: return "Latein"
        case .french: return "Französisch"
        case .spanish: return "Spanisch"
            
        case .sports: return "Sport"
            
        }
    }
    
    var icon: Image {
        
        switch self {
            
        case .german: return Image(systemName: "book")
        case .maths: return Image(systemName: "function")
        case .english: return Image(systemName: "book")
        
        case .physics: return Image(systemName: "atom")
        case .biology: return Image(systemName: "leaf")
        case .chemistry: return Image(systemName: "sink")
        case .computerScience: return Image(systemName: "desktopcomputer")
        
        case .politics: return Image(systemName: "person.3")
        case .geography: return Image(systemName: "globe.europe.africa")
        case .philosophy: return Image(systemName: "lightbulb")
        case .history: return Image(systemName: "hourglass")
        case .katholicReligion: return Image(systemName: "book.closed")
        case .protestantReligion: return Image(systemName: "book.closed")
        
        case .music: return Image(systemName: "music.note")
        case .art: return Image(systemName: "paintpalette")
        
        case .latin: return Image(systemName: "scroll")
        case .french: return Image(systemName: "book")
        case .spanish: return Image(systemName: "book")
            
        case .sports: return Image(systemName: "figure.pool.swim")
            
        }
    }
    
    var color: Color {
        
        switch self {
            
        case .german: return Color.green
        case .maths: return Color.blue
        case .english: return Color.red
        
        case .physics: return Color.blue.opacity(0.7)
        case .biology: return Color.green.opacity(0.9)
        case .chemistry: return Color(red: 0.8, green: 1.0, blue: 0.2)
        case .computerScience: return Color.gray
        
        case .politics: return Color(red: 0.0, green: 0.0, blue: 0.5)
        case .geography: return Color(red: 0.25, green: 0.88, blue: 0.82)
        case .philosophy: return Color(red: 0.5, green: 0.0, blue: 0.0)
        case .history: return Color(red: 0.8, green: 0.5, blue: 0.2)
        case .katholicReligion, .protestantReligion: return Color(red: 0.8, green: 0.6, blue: 0.8)
    
        
        case .music: return Color.pink
        case .art: return Color.yellow
        
        case .latin: return Color(red: 0.6, green: 0.4, blue: 0.2)
        case .french: return Color.purple
        case .spanish: return Color.orange
            
        case .sports: return Color.teal
            
        }
    }
    
    
}
