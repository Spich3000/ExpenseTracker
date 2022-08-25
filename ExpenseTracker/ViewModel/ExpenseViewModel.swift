//
//  ExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Дмитрий Спичаков on 22.08.2022.
//

import Foundation
import SwiftUI

class ExpenseViewModel: ObservableObject {
    
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var currentMonthStartDate: Date = Date()
    
    // Expense/Income tab
    @Published var tabName: ExpenseType = .expense
    //Filter view
    @Published var showFilterView = false
    // New expense properties
    @Published var addNewExpense = false
    @Published var amount: String = ""
    @Published var type: ExpenseType = .all
    @Published var date = Date()
    @Published var remark: String = ""
    
    
    init() {
        // Fetching current month Starting Date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month], from: Date())
        
        startDate = calendar.date(from: components)!
        currentMonthStartDate = calendar.date(from: components)!
    }
    
    // Sample
    @Published var expenses: [Expense] = sample_expenses
    
    // Fetching Current month date string
    func currentMonthDateString() -> String {
        return currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date: .abbreviated, time: .omitted)
    }
    
    func convertExpensesToCurrency(expenses: [Expense], type: ExpenseType = .all) -> String {
        var value: Double = 0
            value = expenses.reduce(0, { partialResult, expense in
                return partialResult + (type == .all ? (expense.type == .income ? expense.amount : -expense.amount) : (expense.type == type ? expense.amount : 0))
            })
           return convertNumberToPrice(value: value)
    }
    
    // Convert selected dates to string
    func convertDateToString() -> String {
        return startDate.formatted(date: .abbreviated, time: .omitted) + " - " + endDate.formatted(date: .abbreviated, time: .omitted)
    }
    
    // Converting number to price
    func convertNumberToPrice(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: .init(value: value)) ?? "$0.00"
    }
    
    // clear all data
    func clearData() {
        date = Date()
        type = .all
        remark = ""
        amount = ""
    }
    
    // save Data
    func saveData(env: EnvironmentValues) {
        // Add coredata atfirst
        print("Save")
        let amountInDouble = (amount as NSString).doubleValue
        let colors = ["Yellow", "Red", "Purple", "Green"]
        let expense = Expense(remark: remark, amount: amountInDouble, date: date, type: type, color: colors.randomElement() ?? "Yellow")
        withAnimation {
            expenses.append(expense)
            expenses = expenses.sorted(by: { first, scnd in
                return scnd.date < first.date
            })
            env.dismiss()
        }
    }
    
}
