//
//  ContentView.swift
//  WeSplit
//
//  Created by SK Ruban on 21/6/20.
//  Copyright © 2020 SK Ruban. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var amount = ""
    @State var people = 2
    @State var tipPercentage = 0
    
    let tipPercentages = [0,10,15,20,25]
    
    var personOrPeople: String {
        if Int(people) == 1 {
            return "Person"
        }
        else {
            return "People"
        }
    }
    
    var totalPerPax: Double {
        let peopleCount = Double(people)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(amount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPax = grandTotal / peopleCount
        
        return amountPerPax
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Input the Fee & Number of People")){
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    Stepper(value: $people, in: 1...30){
                        Text("\(people) \(personOrPeople)")
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0 ..< tipPercentages.count){ value in
                            Text("\(self.tipPercentages[value])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("The Amount per Person is:")){
                    Text("$\(totalPerPax, specifier: "%.2f")")
                }
                
            }
            .navigationBarTitle(Text("💸 WeSplit"))
        }
    }
    
    init() {
      let navBarAppearance = UINavigationBar.appearance()
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
      navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


