//
//  TransactionsCardView.swift
//  ExpenseTracker
//
//  Created by Дмитрий Спичаков on 22.08.2022.
//

import SwiftUI

struct TransactionsCardView: View {
    
    var expense: Expense
    @EnvironmentObject var viewModel: ExpenseViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            // First leter Avatar
            if let first = expense.remark.first {
                Text(String(first))
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(Circle().fill(Color(expense.color)))
                    .shadow(color: .black.opacity(0.07), radius: 5, x: 5, y: 5)
            }
            
            Text(expense.remark)
                .fontWeight(.semibold)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .trailing, spacing: 7) {
                // Displaying price
                
            }
        }
    }
}

struct TransactionsCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
