//
//  Utilities.swift
//  vertretungsplan-pgu
//
//  Created by Wolf Jonas Friederichs on 9/4/21.
//

import Foundation


struct Constants {
    
    let hashedPasswordSchuelerString = "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08"
    
}


func getImageURL(day: day) async throws -> [URL?] {

    var urls: [[URL?]] = [[]]

        do {
            urls = try await createImageURLs()
        } catch {
            throw error
        }
        
        switch day {
        case .today:
            return urls[0]
        case .tomorrow:
            return urls[1]
        }
    
}


func createImageURLs() async throws -> [[URL?]] {
    
    var todayURLs: [URL?] = []
    var tomorrowURLs: [URL?] = []
    
    let urlSession = URLSession.shared
    
    do {
        let dataTask = try await urlSession.data(from: createPGUURL(day: .today))
        
        if dataTask.1.mimeType == "image/png" {
            todayURLs.append(createPGUURL(day: .today))
        } else {
            todayURLs.append(createPGUURL(day: .today1))
            todayURLs.append(createPGUURL(day: .today2))
        }
        
    } catch {
        throw error
    }
    
    do {
        let dataTask = try await urlSession.data(from: createPGUURL(day: .tomorrow))
        
        if dataTask.1.mimeType == "image/png" {
            tomorrowURLs.append(createPGUURL(day: .tomorrow))
        } else {
            tomorrowURLs.append(createPGUURL(day: .tomorrow1))
            tomorrowURLs.append(createPGUURL(day: .tomorrow2))
        }
        
    } catch {
        throw error
    }
    
    return [todayURLs, tomorrowURLs]
    
}


func createPGUURL(day: multipleDay) -> URL {
    
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



enum multipleDay { case today, today1, today2, tomorrow, tomorrow1, tomorrow2 }
enum day { case today, tomorrow }
