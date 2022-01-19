//
//  SubstitutionsModel.swift
//  vertretungsplan-pgu
//
//  Created by Wolf Jonas Friederichs on 9/30/21.
//

import Foundation


struct Vertretung: Codable, Hashable {
    
    let klasse: String
    var kurs: String
    let stunde: String
    var vertreter: String
    var raum: String
    let art: String
    var datum: String
    
}
