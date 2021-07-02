//
//  StoringDataWithUserDefaults.swift
//  iExpense
//
//  Created by Alexander Bonney on 5/8/21.
//
//  UserDefaults allows us to store small amount of user data directly attached to our app. There is no specific number attached to “small”, but you should keep in mind that everything you store in UserDefaults will automatically be loaded when your app launches – if you store a lot in there your app launch will slow down.
//
//  UserDefaults is perfect for storing user settings and other important data – you might track when the user last launched the app, which news story they last read, or other passively collected information.
//
//  First, we need to write the tap count to UserDefaults whenever it changes, so add this after the line self.tapCount += 1
//
/*
    In just that single line of code you can see three things in action:
 
    We need to use UserDefaults.standard. This is the built-in instance of UserDefaults that is attached to our app, but in more advanced apps you can create your own instances. For example, if you want to share defaults across several app extensions you might create your own UserDefaults instance.
    There is a single set() method that accepts any kind of data – integers, Booleans, strings, and more.
    We attach a string name to this data, in our case it’s the key “Tap”. This key is case-sensitive just like regular Swift strings, and it’s important – we need to use the same key to read the data back out of UserDefaults.
 */

import SwiftUI

struct StoringDataWithUserDefaults: View {
    
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            UserDefaults.standard.set(tapCount, forKey: "Tap")
        }
    }
}

struct StoringDataWithUserDefaults_Previews: PreviewProvider {
    static var previews: some View {
        StoringDataWithUserDefaults()
    }
}
