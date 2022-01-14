//
//  ContentView.swift
//  CreditCounter
//
//  Created by Алексей Гончаров on 14.01.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var creditSum = 0.0
    @State private var creditPeriod = 0
    @State private var percent = 10
    @FocusState private var creditSumIsFocused: Bool
    
    let percentRates = [5, 10, 15, 20]
    
    var totalPerMonth: Double {
        let yearsCount = Double(creditPeriod + 1)
        let percentSelection = Double(percent)
        
        let percentValue = creditSum / 100 * percentSelection
        let grandTotal = creditSum + (percentValue * yearsCount)
        let sumPerYear = grandTotal / yearsCount
        let sumPerMounth: Double = sumPerYear / 12
        
        return sumPerMounth
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                        TextField("Сумма кредита", value: $creditSum, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($creditSumIsFocused)
                        
                        Picker("Срок кредита в годах", selection: $creditPeriod) {
                            ForEach(1..<6) {
                                Text("\($0)")
                            }
                        }
                    }
                
                
                Section {
                    Picker("Какая процентная ставка по кредиту?", selection: $percent) {
                        ForEach(percentRates, id: \.self) {
                                Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Процентная ставка")
                }
                
                Section {
                        Text(totalPerMonth, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Ежемесячная выплата по кредиту")
                }
            }
            .navigationBarTitle("Счетчик кредита")
            .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Done") {
                            creditSumIsFocused = false
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


