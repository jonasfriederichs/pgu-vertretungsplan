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
    var vertreter: String
    let fach: String
    var raum: String
    let art: String
    let vertretungstext: String
    var date: String
    
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

struct SubstitutionUtils {
    
    static func prepareSubstitution(string: String) throws -> Vertretung {
        
        let jsonDecoder = JSONDecoder()
        
        guard let stringData = string.data(using: .utf8) else { throw SubstitutionLoadingError.StringToDataConversionFail }
        
        var vertretung = try jsonDecoder.decode(Vertretung.self, from: stringData)
        
        vertretung.raum = vertretung.raum.split(separator: "?").joined(separator: " ➜ ")
        
        vertretung.vertreter = vertretung.vertreter.split(separator: "?").joined(separator: " ➜ ")
        
        vertretung.date = vertretung.date.split(separator: "-").joined(separator: ".")
        
        return vertretung
        
    }
    
}
