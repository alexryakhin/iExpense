//
//  ListAndHowToDeleteItems.swift
//  iExpense
//
//  Created by Alexander Bonney on 5/8/21.
//
//  SwiftUI gives us the onDelete() modifier for us to use to control how objects should be deleted from a collection. In practice, this is almost exclusively used with List and ForEach: we create a list of rows that are shown using ForEach, then attach onDelete() to that ForEach so the user can remove rows they don’t want.
//
//  In order to make onDelete() work, we need to implement a method that will receive a single parameter of type IndexSet. This is a bit like a set of integers, except it’s sorted, and it’s just telling us the positions of all the items in the ForEach that should be removed.
//
//  Because our ForEach was created entirely from a single array, we can actually just pass that index set straight to our numbers array – it has a special remove(atOffsets:) method that accepts an index set.

import SwiftUI

struct ListAndHowToDeleteItems: View {
    
    @State private var collection = [Int]()
    @State private var number = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(collection, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                Button("Add item") {
                    //do somth
                    collection.append(number)
                    number += 1
                }
            }
            .navigationBarItems(trailing: EditButton())
            .navigationTitle("List of numbers")
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        collection.remove(atOffsets: offsets)
    }
}

struct ListAndHowToDeleteItems_Previews: PreviewProvider {
    static var previews: some View {
        ListAndHowToDeleteItems()
    }
}
