//
//  Utilities.swift
//  vertretungsplan-pgu
//
//  Created by Wolf Jonas Friederichs on 9/4/21.
//

import Foundation


func createImageURLs() async throws -> [[URL?]] {
    
    var todayURLs: [URL?] = []
    var tomorrowURLs: [URL?] = []
    
    let urlSession = URLSession.shared
    
    do {
        let dataTask = try await urlSession.data(from: createImageURL(day: .today))
        
        if dataTask.1.mimeType == "image/png" {
            todayURLs.append(createImageURL(day: .today))
        } else {
            todayURLs.append(createImageURL(day: .today1))
            todayURLs.append(createImageURL(day: .today2))
        }
        
    } catch {
        throw error
    }
    
    do {
        let dataTask = try await urlSession.data(from: createImageURL(day: .tomorrow))
        
        if dataTask.1.mimeType == "image/png" {
            tomorrowURLs.append(createImageURL(day: .tomorrow))
        } else {
            tomorrowURLs.append(createImageURL(day: .tomorrow1))
            tomorrowURLs.append(createImageURL(day: .tomorrow2))
        }
        
    } catch {
        throw error
    }
    
    return [todayURLs, tomorrowURLs]
    
}


func createImageURL(day: day) -> URL {
    
    var components = URLComponents()
    components.scheme = "https"
    components.host = "www.pgu.de"
    
    switch day {
    case .today: components.path = "/fileadmin/Vertretungsplan/Neu/Plaene/plan_heute_schueler.png"
    case .today1: components.path = "/fileadmin/Vertretungsplan/Neu/Plaene/plan_heute_schueler-0.png"
    case .today2: components.path = "/fileadmin/Vertretungsplan/Neu/Plaene/plan_heute_schueler-1.png"
    case .tomorrow: components.path = "/fileadmin/Vertretungsplan/Neu/Plaene/plan_morgen_schueler.png"
    case .tomorrow1: components.path = "/fileadmin/Vertretungsplan/Neu/Plaene/plan_morgen_schueler-0.png"
    case .tomorrow2: components.path = "/fileadmin/Vertretungsplan/Neu/Plaene/plan_morgen_schueler-1.png"
    }
    
    return components.url!
    
}



enum day { case today, today1, today2, tomorrow, tomorrow1, tomorrow2 }
