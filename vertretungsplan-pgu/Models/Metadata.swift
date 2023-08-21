//
//  Metadata.swift
//  vertretungsplan-pgu
//
//  Created by Jonas Friederichs on 20.08.23.
//

import Foundation


//@Model
class Metadata {
    
    init(id: UUID, additionalInformation: [String], affectedClasses: [String], date: Date, weekType: String) {
        self.id = id
        self.additionalInformation = additionalInformation
        self.affectedClasses = affectedClasses
        self.date = date
        self.weekType = weekType
    }
    
    var id: UUID?
    
    var additionalInformation: [String]?
    
    var affectedClasses: [String]?
    
    var date: Date?
    
    var weekType: String?
    
}
