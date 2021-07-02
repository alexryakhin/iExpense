//
//  Second View.swift
//  iExpense
//
//  Created by Alexander Bonney on 5/8/21.
//

import SwiftUI

struct Second_View: View {
    //to dismiss the second view with a button, i have to use @Environment property wrapper with var called presentation mode. The presentation mode of a view contains only two pieces of data, but both are useful: a property storing whether the view is currently presented on screen, and a method to let us dismiss the view immediately. So we just created the button with dismiss action.
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button("Dismiss") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct Second_View_Previews: PreviewProvider {
    static var previews: some View {
        Second_View()
    }
}
