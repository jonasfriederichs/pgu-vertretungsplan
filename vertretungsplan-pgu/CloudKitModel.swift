//
//  CloudKitModel.swift
//  vertretungsplan-pgu
//
//  Created by Jonas Friederichs on 20.08.23.
//

import Foundation
import CloudKit


struct CloudKitModel {
    
    let helper = CloudKitHelper()
    
    func fetchSubstitutions(className: String) async -> Result<[Substitution], Error> {
        
//        let predicate = className == "all" ? NSPredicate(value: true) : NSPredicate(format: "class_name CONTAINS[c] %@", className)
        let predicate = NSPredicate(value: true)
        
        let resultFetch = await fetchSubRecords(predicate: predicate)
        switch resultFetch {
        case .success(let records):
            let dicts = records.map { record in convertSubstitutionCKRecordToDictionary(record: record)}
            
            var substitutions = dicts.compactMap { dictionaryToSubstitution(dict: $0) }
            
            print("Success: \(substitutions)")
            
            return .success(substitutions)
            
        case .failure(let error):
            return .failure(error)
        }
        
    }
    
    
    
// MARK: - fetch
    
    func fetchSubRecords(predicate: NSPredicate) async -> Result<[CKRecord], Error>{
        
        print("Fetch Substitutions started")
        
        do {
            let records = try await helper.fetchRecords(ofType: Constants.recordNames.substitution.name, withPredicate: predicate)
            return .success(records)
        } catch(let error) {
            print("Error fetching substitutions: \(error.localizedDescription)")
            return .failure(error)
        }
    }
    
//MARK: - convert
    
    func convertSubstitutionCKRecordToDictionary(record: CKRecord) -> [String: Any]? {
        guard let room = record["room"] as? String,
              let hour = record["hour"] as? String,
              let subject = record["subject"] as? String,
              let teacher = record["teacher"] as? String,
              let className = record["class_name"] as? String,
              let date = record["date"] as? Date,
              let substitutionType = record["substitution_type"] as? String
        else {
            return nil // Return nil if any of the required fields are missing
        }

        let result: [String: Any] = [
            "id": record.recordID.recordName, // Extracting recordName as the ID
            "room": room,
            "hour": hour,
            "subject": subject,
            "teacher": teacher,
            "class_name": className,
            "date": date,
            "substitution_type": substitutionType
        ]
        
        return result
    }
    
    
    func dictionaryToSubstitution(dict: [String: Any]?) -> Substitution? {
        
        guard let dict = dict else { return nil }
        
        print(dict)
        
        guard let room = dict["room"] as? String,
              let hour = dict["hour"] as? String,
              let subjectString = dict["subject"] as? String,
              let teacher = dict["teacher"] as? String,
              let className = dict["class_name"] as? String,
              let date = dict["date"] as? Date,
              let substitutionType = dict["substitution_type"] as? String,
              let idString = dict["id"] as? String,
              let id = UUID(uuidString: idString)
        else {
            return nil
        }
        
        let currentDate = Calendar.current.startOfDay(for: Date())
        let substitutionDate = Calendar.current.startOfDay(for: date)
        
        let day: Day
        if currentDate == substitutionDate {
            day = .today
        } else {
            day = .tomorrow
        }
        
        let subjects = assignSubjects(subjectString: subjectString)
        
        guard let primarySubject = subjects.0 else { return nil }
        
        return Substitution(day: day, date: date, className: className, hour: hour, room: room, subject: primarySubject, secondarySubject: subjects.1, type: substitutionType, teacher: teacher, id: id)
    }
    
    
    func assignSubjects(subjectString: String) -> (Subject?, Subject?) {
        
        let components = subjectString.split(separator: "→", omittingEmptySubsequences: true)

        // If you want the results as an array of Strings:
        var stringComponents = components.map { String($0) }
        
        if stringComponents.count == 1 {
            let arrowUnicode = "\u{2192}"  // Unicode for →
            let components2 = stringComponents[0].split(separator: Character(arrowUnicode), omittingEmptySubsequences: true)
            stringComponents = components2.map { String($0) }
        }
        
        print(stringComponents)
        
        var resultArray: [Subject?] = []
        for i in 0...(stringComponents.count - 1) {
            
            let subject: Subject?
            switch stringComponents[i].split(separator: " ", omittingEmptySubsequences: true)[0] {
            case "D": subject = .german
            case "M": subject = .maths
            case "E": subject = .english
            case "PH": subject = .physics
            case "BI": subject = .biology
            case "CH": subject = .chemistry
            case "IF": subject = .computerScience
            case "P": subject = .politics
            case "SW": subject = .politics
            case "EK": subject = .geography
            case "PL": subject = .philosophy
            case "GE": subject = .history
            case "MU": subject = .music
            case "KU": subject = .art
            case "L": subject = .latin
            case "F": subject = .french
            case "S": subject = .spanish
            case "SP": subject = .sports
            default: subject = nil
            }
            
            resultArray.append(subject)
            
        }
        
        print(resultArray)
        
        if resultArray.count == 1 {
            return (resultArray[0], nil)
        } else if resultArray.count == 2 {
            return (resultArray[0], resultArray[1])
        } else {
            return (nil, nil)
        }
        
    }
    
    
    
// MARK: - save local
    
//    @MainActor
//    func saveToSwiftData(items: [Substitution], context: ModelContext) {
//        
//        let _ = items.map { context.insert($0) }
//
//        
//        do {
//            try context.save()
//        } catch(let error) {
//            print("fatal error saving: \(error.localizedDescription)")
//        }
//            
//    }
    
    
}
