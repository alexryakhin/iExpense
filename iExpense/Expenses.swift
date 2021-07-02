//
//  Expenses.swift
//  iExpense
//
//  Created by Alexander Bonney on 5/9/21.
//
//  That's our View Model
//  Class have to store an array of all those expense items
//
//  Swift already includes Codable conformances for the UUID, String, and Int properties of ExpenseItem, and so it’s able to make ExpenseItem conform automatically as soon as we ask for it.
//
//  With that change, we’ve written all the code needed to make sure our items are saved when the user adds them. However, it’s not effective by itself: the data might be saved, but it isn’t loaded again when the app relaunches.
//
//  To solve that – and also to make our code compile again – we need to implement a custom initializer. That will:
//
//  Attempt to read the “Items” key from UserDefaults.
//  Create an instance of JSONDecoder, which is the counterpart of JSONEncoder that lets us go from JSON data to Swift objects.
//  Ask the decoder to convert the data we received from UserDefaults into an array of ExpenseItem objects.
//  If that worked, assign the resulting array to items and exit.
//  Otherwise, set items to be an empty array.
//  The two key parts of that code are the data(forKey: "Items") line, which attempts to read whatever is in “Items” as a Data object, and try? decoder.decode([ExpenseItem].self, from: items), which does the actual job of unarchiving the Data object into an array of ExpenseItem objects.
//
//  It’s common to do a bit of a double take when you first see [ExpenseItem].self – what does the .self mean? Well, if we had just used [ExpenseItem], Swift would want to know what we meant – are we trying to make a copy of the class? Were we planning to reference a static property or method? Did we perhaps mean to create an instance of the class? To avoid confusion – to say that we mean we’re referring to the type itself, known as the type object – we write .self after it.


import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            //This takes four steps in total: we need to create an instance of JSONEncoder that will do the work of converting our data to JSON, we ask that to try encoding our items array, and then we can write that to UserDefaults using the key “Items”.
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                        UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        self.items = []
    }
}
