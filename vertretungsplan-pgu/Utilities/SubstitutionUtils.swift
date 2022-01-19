//
//  SubstitutionUtils.swift
//  vertretungsplan-pgu
//
//  Created by Wolf Jonas Friederichs on 12/15/21.
//

import Foundation

struct SubstitutionUtils {
    
    let networkingUtils = NetworkingUtils()
    
    func getSubstitutions() async -> [[Vertretung]] {
        
        do {
            
            print("getting 1")
            
            let fetchedVertretungen = try await networkingUtils.getVertretungen()
            
            var vertretungen = Array(Dictionary(grouping: fetchedVertretungen) {$0.datum}.values)
            
            for i in 0...vertretungen.count-1 {
                vertretungen[i].sort { $0.stunde < $1.stunde }
            }
            
            return vertretungen
            
        } catch {
            print(error)
        }

        return []
        
    }
    
}
