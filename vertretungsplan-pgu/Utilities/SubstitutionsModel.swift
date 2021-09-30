//
//  SubstitutionsModel.swift
//  vertretungsplan-pgu
//
//  Created by Wolf Jonas Friederichs on 9/30/21.
//

import Foundation


struct Vertretung: Codable {
    
    let id: String
    let klasse: String
    let kurs: String
    let stunde: String
    let vertreter: String
    let fach: String
    let raum: String
    let art: String
    let vertretungstext: String
    let date: String
    
    enum codingKeys: String, CodingKey {
        
        case id = "hash"
        case klasse
        case kurs
        case stunde
        case vertreter
        case fach
        case raum
        case art
        case vertretungstext
        case date
    }
    
}
