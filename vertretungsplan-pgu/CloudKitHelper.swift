//
//  CloudKitHelper.swift
//  vertretungsplan-pgu
//
//  Created by Jonas Friederichs on 20.08.23.
//

import Foundation
import CloudKit

enum CloudKitHelperError: Error {
    case noRecordsFound
    case underlyingError(Error)
}


extension CKDatabase {
    func fetchAsync(withQuery query: CKQuery, inZoneWith zoneID: CKRecordZone.ID?, desiredKeys: [CKRecord.FieldKey]? = nil, resultsLimit: Int = 100) async throws -> [(CKRecord.ID, Result<CKRecord, Error>)] {
        return try await withCheckedThrowingContinuation { continuation in
            self.fetch(withQuery: query, inZoneWith: zoneID, desiredKeys: desiredKeys, resultsLimit: resultsLimit) { result in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data.matchResults)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}


class CloudKitHelper {
    
    let container: CKContainer
    let publicDatabase: CKDatabase
    
    init() {
        container = CKContainer.default()
        publicDatabase = container.publicCloudDatabase
    }
    
    func fetchRecords(ofType type: String, withPredicate predicate: NSPredicate = NSPredicate(value: true), desiredKeys: [CKRecord.FieldKey]? = nil, resultsLimit: Int = 100) async throws -> [CKRecord] {
        
        print("fetch records started: \(predicate)")
        
        let query = CKQuery(recordType: type, predicate: predicate)
        
        let matchResults = try await publicDatabase.fetchAsync(withQuery: query, inZoneWith: nil, desiredKeys: desiredKeys, resultsLimit: resultsLimit)
        let records = matchResults.compactMap { (_, recordResult) -> CKRecord? in
            switch recordResult {
            case .success(let record):
                return record
            case .failure:
                return nil
            }
        }
        
        if records.isEmpty {
            throw CloudKitHelperError.noRecordsFound
        } else {
            return records
        }
    }
}
