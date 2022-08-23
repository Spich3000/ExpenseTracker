//
//  Home.swift
//  ExpenseTracker
//
//  Created by Дмитрий Спичаков on 21.08.2022.
//

import SwiftUI

struct Home: View {
    
    @StateObject var viewModel = ExpenseViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators:  false) {
            VStack(spacing: 12) {
                HStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        
                        Text("ExpenseTrackerMotherFucka")
                            .font(.title2.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "hexagon.fill")
                            .foregroundColor(.gray)
                            .overlay(Circle().stroke(.white, lineWidth: 2).padding(7))
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                }
                ExpenseCardView()
                TransactionsView()
            }
            .padding()
        }
        .background(Color("BG").ignoresSafeArea())
    }
    
    // MARK: Transactions View
    @ViewBuilder
    func TransactionsView() -> some View {
        VStack {
            Text("Transactions")
                .font(.title2.bold())
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            
            ForEach(viewModel.expenses) { expense in
                // Transaction Card View
                TransactionsCardView(expense: expense)
                    .environmentObject(viewModel)
            }
        }
        .padding(.top)
    }
    
    
    // MARK: Expense gradient card view
    @ViewBuilder
    func ExpenseCardView() -> some View {
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.linearGradient(colors: [
                Color("Gradient1"),
                Color("Gradient2"),
                Color("Gradient3"),
                ], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            VStack(spacing: 15) {
                VStack(spacing: 15) {
                    // Currently going month date string
                    Text(viewModel.currentMonthDateString())
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    // Current month Expenses Price
                    Text(viewModel.convertExpensesToCurrency(expenses: viewModel.expenses))
                        .font(.system(size: 35, weight: .bold))
                        .lineLimit(1)
                        .padding(.bottom)
                    
                }
                .offset(y: -10)
                
                HStack(spacing: 15) {
                    Image(systemName: "arrow.down")
                        .font(.callout.bold())
                        .foregroundColor(Color("Green"))
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.7), in: Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Income")
                            .font(.caption)
                            .opacity(0.7)
                        
                        Text(viewModel.convertExpensesToCurrency(expenses: viewModel.expenses, type: .income))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "arrow.up")
                        .font(.callout.bold())
                        .foregroundColor(Color("Red"))
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.7), in: Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Expenses")
                            .font(.caption)
                            .opacity(0.7)
                        
                        Text(viewModel.convertExpensesToCurrency(expenses: viewModel.expenses, type: .expense))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                }
                .padding(.horizontal)
                .padding(.trailing)
                .offset(y: 15)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 220)
        .padding(.top)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
