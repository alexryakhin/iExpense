//
//  User.swift
//  iExpense
//
//  Created by Alexander Bonney on 5/8/21.
//

import Foundation

class User: ObservableObject {
    @Published var firstName: String = "Alex"
    @Published var secondName: String = "Bonney"
}
