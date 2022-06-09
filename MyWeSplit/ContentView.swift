//
//  ContentView.swift
//  MyWeSplit
//
//  Created by Matt Stillwell on 6/7/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numPeople: Int = 0
    @State private var tipPercent: Int = 20
    @FocusState private var amountIsFocused: Bool
    
    private var tipAmount: Double {
        return checkAmount * Double(tipPercent) / 100.0
    }
    private var totalAmount: Double {
        return checkAmount + tipAmount
    }
    private var totalAmountPerPerson: Double {
        return totalAmount / Double(numPeople + 2)
    }
    
    let tipPercents: [Int] = [10, 15, 20, 25, 0]
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Num People", selection: $numPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percent", selection: $tipPercent) {
                        ForEach(tipPercents, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("TIP PERCENT")
                }
                
                Section {
                    Text(tipAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("TIP AMOUNT DUE")
                }
                
                Section {
                    Text(totalAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("TOTAL AMOUNT DUE")
                }
                
                Section {
                    Text(totalAmountPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("TOTAL AMOUNT PER PERSON DUE")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
