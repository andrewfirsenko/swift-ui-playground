//
//  ContentView.swift
//  SwiftUIPlayground
//
//  Created by Andrew on 05.02.2025.
//

import SwiftUI

private extension String {
    static let usd: String = "USD"
}

struct ContentView: View {
    
    private let currencyCode: String = Locale.current.currency?.identifier ?? .usd
    private let tipPercentages: [Int] = [10, 15, 20, 25, 30, 0]
    @State private var currentAmount: Double = 0.0
    @State private var currentTip: Int = 20
    @State private var numberOfPeopleIndex: Int = 0
    @FocusState private var isFocusedAmount: Bool
    
    private var totalResult: Double {
        let people: Int = numberOfPeopleIndex + 2
        let tipAmount: Double = currentAmount * Double(currentTip) / 100
        return (currentAmount + tipAmount) / Double(people)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("How much did you spend") {
                    TextField(
                        "Amount",
                        value: $currentAmount,
                        format: .currency(code: currencyCode)
                    )
                    .keyboardType(.decimalPad)
                    .focused($isFocusedAmount)
                }
                
                Section("How many people do you divide the check") {
                    Picker("Number of people", selection: $numberOfPeopleIndex) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip") {
                    Picker("Tip", selection: $currentTip) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Result") {
                    Text(totalResult, format: .currency(code: currencyCode))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if isFocusedAmount {
                    Button("Done") {
                        isFocusedAmount = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
