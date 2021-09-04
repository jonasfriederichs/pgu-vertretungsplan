//
//  ContentView.swift
//  vertretungsplan-pgu
//
//  Created by Wolf Jonas Friederichs on 9/4/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        FullPlanView(day: .today)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
