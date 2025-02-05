//
//  ContentView.swift
//  SwiftUIPlayground
//
//  Created by Andrew on 05.02.2025.
//

import SwiftUI

struct ContentView: View {
    
    private let statements = ["First", "Second", "Third"]
    @State private var currentSelection = "First"
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Position", selection: $currentSelection) {
                    ForEach(statements, id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationTitle("Select the position")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
