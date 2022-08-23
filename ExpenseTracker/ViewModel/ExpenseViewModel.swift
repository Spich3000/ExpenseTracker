//
//  ExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Дмитрий Спичаков on 22.08.2022.
//

import Foundation

class ExpenseViewModel: ObservableObject {
    
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var currentMonthStartDate: Date = Date()
    
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
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            
            return formatter.string(from: .init(value: value)) ?? "$0.00"
        
    }
    
    
    // Converting number to price
    func convertNumberToPrice() {
        
    }
    
}
