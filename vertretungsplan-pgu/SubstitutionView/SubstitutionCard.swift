//
//  SubstitutionView.swift
//  vertretungsplan-ui
//
//  Created by Jonas Friederichs on 11.06.23.
//

import SwiftUI


struct SubstitutionCard: View {
    
    var substitution: Substitution
    
    @State private var existsSecondary = false
    
    let animationDuration: Double = 1.0
    let pauseDuration: Double = 2.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 10) {
                if existsSecondary {
                    substitution.secondarySubject?.icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(substitution.secondarySubject?.color)
                } else {
                    substitution.subject?.icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(substitution.subject?.color)
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    VStack(alignment: .leading) {
                        Text(existsSecondary ? substitution.secondarySubject?.name ?? "Fehler" : substitution.subject?.name ?? "Fehler")
                            .font(.headline)
                        
                        Text(existsSecondary ?
                             substitution.subject?.name ?? "Fehler" : "")
                        .font(.subheadline)
                        .strikethrough()
                    }
                    
                    Text("Raum: \(substitution.room ?? "Fehler")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Lehrer: \(substitution.teacher ?? "Fehler")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Klasse(n): \(substitution.classNames ?? "Fehler")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
            }
            
            Text("\(substitution.type ?? "Fehler")")
                .font(.subheadline)
                //.foregroundColor(.gray)
            
            Text("Stunde: \(substitution.hour ?? "Fehler")")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Datum: \(Formatter.dateFormatter.string(from: substitution.date ?? Date()))")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(existsSecondary ? substitution.secondarySubject?.color.opacity(0.18) : substitution.subject?.color.opacity(0.18))
        .cornerRadius(10)
        .onAppear(perform: {
            if let _ = substitution.secondarySubject { existsSecondary = true }
        })
    }

}



extension Formatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "dd.MM."
        return formatter
    }()
}


struct SubstitutionCard_Previews: PreviewProvider {
    
    static var previews: some View {
        
        SubstitutionCard(substitution: Substitution(day: Day.today, date: Date(), className: "6B", room: "105->117", subject: .maths, secondarySubject: .physics, type: "Vertretung", teacher: "KAM->VOGT"))
        
    }
    
}
