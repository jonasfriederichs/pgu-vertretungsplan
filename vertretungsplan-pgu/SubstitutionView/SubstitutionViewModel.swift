//
//  SubstitutionViewModel.swift
//  vertretungsplan-pgu
//
//  Created by Jonas Friederichs on 22.06.23.
//

import Foundation
import Combine
import SwiftUI


class SubstitutionViewModel: ObservableObject {
    
    let CKModel = CloudKitModel()
    
    func fetch(className: String) async -> [Substitution]{
        
        let result = await CKModel.fetchSubstitutions(className: className)
        
        switch result {
        case .success(let subs):
            return subs
        case .failure(let error):
            print(error.localizedDescription)
            return []
        }
        
    }
    
}
