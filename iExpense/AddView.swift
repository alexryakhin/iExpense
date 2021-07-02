//
//  AddView.swift
//  iExpense
//
//  Created by Alexander Bonney on 5/9/21.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses = Expenses()
    
    @State private var showingAlert = false
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                
                //We need to put those two things together: we need a button that, when tapped, creates an ExpenseItem out of our properties and adds it to the expenses items. Our ExpenseItem struct has an integer for its amount, which means we need to do a little typecasting from the string value of amount.
                if let actualAmount = Int(amount) {
                    let item = ExpenseItem(name: name, type: type, amount: actualAmount)
                    expenses.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                } else {
                    showingAlert = true
                }
                
            }).alert(isPresented: $showingAlert, content: {
                Alert(title: Text("Amount error"), message: Text("You can't type '\(amount)', please type some money amount that you expect to spend or get"), dismissButton: .default(Text("Continue")))
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
