//
//  AddView.swift
//  iExpense
//
//  Created by SK Ruban on 29/4/20.
//  Copyright © 2020 SK Ruban. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @State private var showAlert = false
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode

    static let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
                else {
                    self.showAlert = true
                }
                })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Invalid Amount"), message: Text("Nigga, enter a number"), dismissButton: .default(Text("OK")))
                }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
