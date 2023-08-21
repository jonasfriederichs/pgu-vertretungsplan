//
//  SubstitutionList.swift
//  vertretungsplan-ui
//
//  Created by Jonas Friederichs on 11.06.23.
//

import SwiftUI

struct SubstitutionList: View {
    
    @EnvironmentObject private var viewModel: SubstitutionViewModel
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @Binding var className: String {
        didSet { print("className changed: \(self)") }
    }
    
//    @Environment(\.modelContext) private var modelContext
    
//    @Query 
    @State var substitutions: [Substitution]

    
    private var columns: [GridItem] {
        let count = horizontalSizeClass == .regular ? 3 : 1
        return Array(repeating: .init(.flexible()), count: count)
    }
    
    private var substitutionsGroupedByType: [String: [Substitution]] {
        Dictionary(grouping: substitutions.compactMap { $0.classNames?.contains(className) == true || className == "all" ? $0 : nil }, by: { $0.day?.text ?? "Heute"})
    }

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(substitutionsGroupedByType.sorted(by: { $0.key < $1.key }), id: \.key) { type, substitutions in
                    Text(type)
                        .font(.title)
                        .padding()
                    
                    LazyVGrid(columns: columns) {
                        ForEach(substitutions.sorted(by: {$0.hour ?? "1" < $1.hour ?? "1"}), id: \.self) { substitution in
                            SubstitutionCard(substitution: substitution)
                                .padding(5)
                                .background(Color(.white))
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 5, y: 10)
                                .cornerRadius(10)
                        }
                    }
                }
                
            }
            .padding()
            .navigationTitle("Vertretungen")
        }
        .navigationViewStyle(.stack) // Specify stack style for NavigationView
        // MARK: - put onAppear stuff here
        .onAppear(perform: {
            print("Current class: \(className)")
            
            Task {
                substitutions = await viewModel.fetch(className: className)
//                let _ = substitutions.map { modelContext.delete($0) }
//                let _ = newSubstitutions.map { modelContext.insert($0) }
                print(substitutionsGroupedByType)
            }
        })
    }
}

//struct SubstitutionList_Previews: PreviewProvider {
//    static var previews: some View {
//        SubstitutionList()
//            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
//            .previewDisplayName("iPhone 14")
//        
//        SubstitutionList()
//            .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
//            .previewDisplayName("iPad Air")
//    }
//}
