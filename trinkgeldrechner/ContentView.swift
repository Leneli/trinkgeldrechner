//
//  ContentView.swift
//  trinkgeldrechner
//
//  Created by  Elena Kuklina on 15.04.2021.
//

import SwiftUI

struct ContentView: View {
  @State private var percent = 0
  @State private var check = ""
  @State private var people = 1
  
  let percents = [0, 5, 10, 15, 20]
  
  var trinkgeld: (Double, Double) {
    let percentValue = Double(percent) / 100
    let checkCurrency = Double(check) ?? 0
    let peopleCounter = Double(people)
    
    let percentageTotalAmount = checkCurrency * percentValue
    let totalAmount = checkCurrency + percentageTotalAmount
    
    let percentagePerPerson = percentageTotalAmount / peopleCounter
    let totalPerPerson = totalAmount / peopleCounter
    
    
    return (total: totalPerPerson, percentage: percentagePerPerson)
  }

  var body: some View {
    NavigationView {
      List {
        Section {
          TextField(
            "Сумма чека",
            text: $check
          )
          
          Picker(
            selection: $people,
            label: Text("Количество человек")
          ) {
            ForEach(1..<11, id: \.self) {
              Text("\($0)")
            }
          }
        }
        
        Section(header: Text("Сколько чаевых вы хотите оставить?")) {
          Picker(
            selection: $percent,
            label: Text("Процент по чаевым")) {
            ForEach(percents, id: \.self) {
              Text("\($0)%")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        
        Section(header: Text("Итак, вы сдолжны заплатить:")) {
          if (Double(check) != nil) {
            Text("\(trinkgeld.0, specifier: "%.2f"), из них на чай \(trinkgeld.1, specifier: "%.2f")")
            
          } else {
            Text("Укажите сумму чека и процент по чаевым")
              .font(.custom("small", size: 13))
              .foregroundColor(.gray)
          }
        }
      }
      .listStyle(GroupedListStyle())
      .navigationTitle("Калькулятор чаевых")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}





struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
