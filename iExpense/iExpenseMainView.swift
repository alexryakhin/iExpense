//
//  iExpenseMainView.swift
//  iExpense
//
//  Created by Alexander Bonney on 5/9/21.
//
//  That's our View

//  Let’s now put that into action with our SwiftUI view, so we can actually see our data on the screen. Most of our view will just be a List showing the items in our expenses, but because we want users to delete items they no longer want we can’t just use a simple List – we need to use a ForEach inside the list, so we get access to the onDelete() modifier.
//
//  First, we need to add an @ObservedObject property in our view, that will create an instance of our Expenses class.
//
//  Remember, using @ObservedObject here asks SwiftUI to watch the object for any change announcements, so any time one of our @Published properties changes the view will refresh its body.
//
//  Second, we can use that Expenses object with a NavigationView, a List, and a ForEach, to create our basic layout.
//
//  That tells the ForEach to identify each expense item uniquely by its name, then prints the name out as the list row.
//
//  We’re going to leverage four important technologies to help us save and load data in a clean way:
//
//  The Codable protocol, which will allow us to archive all the existing expense items ready to be stored.
//  UserDefaults, which will let us save and load that archived data.
//  A custom initializer for the Expenses class, so that when we make an instance of it we load any saved data from UserDefaults
//  A didSet property observer on the items property of Expenses, so that whenever an item gets added or removed we’ll write out changes.

import SwiftUI

struct iExpenseMainView: View {
    
    @ObservedObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        if item.amount < 10 {
                            Text("$\(item.amount)").foregroundColor(.black)
                        } else if item.amount >= 10 && item.amount < 100 {
                            Text("$\(item.amount)").foregroundColor(.green)
                        } else {
                            Text("$\(item.amount)")
                                .foregroundColor(.red)
                                .bold()
                        }
                         
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                //add item to a list, first, create an instance of our item, an then append that instance to our array of data in our viewModel.
                showingAddExpense = true
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expenses: expenses)
            })
        }
        
    }
    
    
    func removeItems(of offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct iExpenseMainView_Previews: PreviewProvider {
    static var previews: some View {
        iExpenseMainView()
    }
}
