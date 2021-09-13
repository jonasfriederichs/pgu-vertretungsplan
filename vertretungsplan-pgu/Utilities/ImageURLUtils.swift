//
//  ImageURLUtils.swift
//  ImageURLUtils
//
//  Created by Wolf Jonas Friederichs on 9/8/21.
//

import Foundation


struct ImageURLUtils {
    
    func getImageURL(day: Day) async throws -> [URL?] {

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
                print("1 image found today")
                todayURLs.append(createPGUURL(day: .today))
            } else {
                print("2 images found today")
                todayURLs.append(createPGUURL(day: .today1))
                todayURLs.append(createPGUURL(day: .today2))
            }
            
        } catch {
            throw error
        }
        
        do {
            let dataTask = try await urlSession.data(from: createPGUURL(day: .tomorrow))
            
            if dataTask.1.mimeType == "image/png" {
                print("1 image found tomorrow")
                tomorrowURLs.append(createPGUURL(day: .tomorrow))
            } else {
                print("2 images found tomorrow")
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


    enum multipleDay { case today, today1, today2, tomorrow, tomorrow1, tomorrow2 }
    

    
}
