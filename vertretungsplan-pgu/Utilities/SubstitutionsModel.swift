//
//  SubstitutionsModel.swift
//  vertretungsplan-pgu
//
//  Created by Wolf Jonas Friederichs on 9/30/21.
//

import Foundation


struct Vertretung: Codable {
    
    let hash: String
    let klasse: String
    let kurs: String
    let stunde: String
    let vertreter: String
    let fach: String
    let raum: String
    let art: String
    let vertretungstext: String
    let date: String
    
}
