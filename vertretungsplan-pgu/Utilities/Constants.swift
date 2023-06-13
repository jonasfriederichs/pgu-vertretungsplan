//
//  Constants.swift
//  Constants
//
//  Created by Wolf Jonas Friederichs on 9/8/21.
//

import Foundation


struct Constants {
    
    static let hashedPasswordSchuelerString = "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08"
    
    static let hashedPasswordLehrerString = "aaacab1f7a18a668afef2ec3e730dd517ddba39e9bca151dc798a7a73095085e"
    
    static let impressum = "© 2021 Jonas Friederichs"
    
    static let informationText = "Hallo, mein Name ist Jonas Friederichs und ich bin Schüler der Q2 hier am PGU. Diese App wurde als Vertretungsplan-App für iOS-Geräte entwickelt und befindet sich momentan in der 1. Version. Falls hier Bugs oder andere Probleme auftreten sollten, meldet diese bitte an mich (info@jonasfriederichs.de) zurück."
    

    
    static func createPDFURL(role: Role, day: Day) -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.pgu.de"
        
        switch role {
            
        case .teacher:
            
            switch day {
            case .today:
                components.path = "/fileadmin/Vertretungsplan/Neu/Plaene/LZ_heute.pdf"
            case .tomorrow:
                components.path = "/fileadmin/Vertretungsplan/Neu/Plaene/LZ_morgen.pdf"
            }
            
        case .student:
            
            switch day {
            case .today:
                components.path = "/fileadmin/Vertretungsplan/Neu/Plaene/Forum_heute.pdf"
            case .tomorrow:
                components.path = "/fileadmin/Vertretungsplan/Neu/Plaene/Forum_morgen.pdf"
            }
            
        }
        
        return components.url!
        
    }
    
}
