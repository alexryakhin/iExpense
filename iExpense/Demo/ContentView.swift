//
//  ContentView.swift
//  iExpense
//
//  Created by Alexander Bonney on 5/8/21.
//
//
//  When working with data like this, Swift gives us a fantastic protocol called Codable: a protocol specifically for archiving and unarchiving data, which is a fancy way of saying “converting objects into plain text and back again.”
//  Swift will automatically generate some code for us that will archive and unarchive User instances for us as needed, but we still need to tell Swift when to archive and what to do with the data.
//
//  This part of the process is powered by a new type called JSONEncoder. Its job is to take something that conforms to Codable and send back that object in JavaScript Object Notation (JSON) – the name implies it’s specific to JavaScript, but in practice we all use it because it’s so fast and simple.
//
//  The Codable protocol doesn’t require that we use JSON, and in fact other formats are available, but it is by far the most common. In this instance, we don’t actually care what sort of data is used, because it’s just going to be stored in UserDefaults.
//
//  To convert our user data into JSON data, we need to call the encode() method on a JSONEncoder. This might throw errors, so it should be called with try or try? to handle errors neatly.

import SwiftUI

struct ContentView: View {
    
    //To use the same data across all our views we need to store them in our ViewModel, which is always should be a class, because when, for example, we change some data in our view, the other view should show already changed data. If I use a struct instead of a class, structs are value types, they get copied, instead to do some pointers.
    
    @ObservedObject var user = User()
    
    @State private var showSecondView = false
    
    var body: some View {
        VStack {
            Text("This is my name: \(user.firstName) \(user.secondName)")
            
            TextField("First name", text: $user.firstName)
            TextField("Second name", text: $user.secondName)
            
            Button("Show second view") {
                showSecondView.toggle()
            }
        }
        .padding()
        .sheet(isPresented: $showSecondView, content: {
            Second_View()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
