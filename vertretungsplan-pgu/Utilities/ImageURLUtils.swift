//
//  ImageURLUtils.swift
//  ImageURLUtils
//
//  Created by Wolf Jonas Friederichs on 9/8/21.
//

import Foundation


struct ImageURLUtils {

    func createPDFURL(role: Role, day: Day) -> URL {
        
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
