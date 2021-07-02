//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Alexander Bonney on 5/9/21.
//
//  That's our model
//  This struct should represent a single item of expense

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var amount: Int
}
