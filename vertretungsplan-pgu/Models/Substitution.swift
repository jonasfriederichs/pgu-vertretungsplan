//
//  Substitution.swift
//  vertretungsplan-ui
//
//  Created by Jonas Friederichs on 11.06.23.
//

import Foundation
import SwiftUI

//@Model 
final class Substitution {
    
    init(day: Day = .today, date: Date = Date(timeIntervalSince1970: TimeInterval(0)), className: String = "5A", hour: String = "1", room: String = "100", subject: Subject = .maths, secondarySubject: Subject? = nil, type: String = "Entfall", teacher: String = "KAM", id: UUID = UUID()) {
        self.id = id
        self.day = day
        self.date = date
        self.classNames = className
        self.hour = hour
        self.room = room
        self.subject = subject
        self.secondarySubject = secondarySubject
        self.type = type
        self.teacher = teacher
    }
    
    var id: UUID?
    
    var day: Day?
    
    var date: Date?
    
    var classNames: String?
    
    var hour: String?
    
    var room: String?
    
    var subject: Subject?
    var secondarySubject: Subject?
    
    var type: String?
    
    var teacher: String?
    
}

extension Substitution: Hashable, Equatable, CustomStringConvertible {
    
    static func == (lhs: Substitution, rhs: Substitution) -> Bool {
        if lhs.day == rhs.day && lhs.date == rhs.date && lhs.classNames == rhs.classNames && lhs.hour == rhs.hour && lhs.subject == rhs.subject && lhs.room == rhs.room && lhs.type == rhs.type && lhs.teacher == rhs.teacher {
            return true
        } else {
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(day)
        hasher.combine(date)
        hasher.combine(classNames)
        hasher.combine(hour)
        hasher.combine(room)
        hasher.combine(subject)
        hasher.combine(type)
        hasher.combine(teacher)
    }
    
    var description: String {
        return "Substitution(day: \(String(describing: day)), date: \(String(describing: date)), classNames: \(String(describing: classNames)), hour: \(String(describing: hour)), subject: \(String(describing: subject)), sec.Subject: \(String(describing: secondarySubject)))" 
    }
    
    
    
}
