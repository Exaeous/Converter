//
//  ContentView.swift
//  Converter
//
//  Created by Samuel Pulukuri on 08/06/22.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 10.0
    @State private var inputUnit = UnitTemperature.celsius
    @State private var outputUnit = UnitTemperature.fahrenheit
    @FocusState private var valueIsFocused: Bool
    
    let units:[UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    
    let formatter: MeasurementFormatter
    
    var result: String {
        let inputMeasurement = Measurement(value: inputValue, unit: inputUnit)
        let outputMeasurement = inputMeasurement.converted(to: outputUnit)
        
        return formatter.string(from: outputMeasurement)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)
                    Picker("Convert from", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                } header: {
                    Text("Value to convert from")
                }
                
                Section {
                    Picker("Convert to", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                } header: {
                    Text("Value to convert to")
                }
                
                Section {
                    Text(result)
                } header: {
                    Text("Converted value")
                }
            }
            .navigationTitle("Converter")
            .toolbar() {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Close"){
                        valueIsFocused = false
                    }
                }
            }
        }
    }
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
