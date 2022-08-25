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
                    
                    NavigationLink {
                        FilteredDetailView()
                            .environmentObject(viewModel)
                    } label: {
                        Image(systemName: "hexagon.fill")
                            .foregroundColor(.gray)
                            .overlay(Circle().stroke(.white, lineWidth: 2).padding(7))
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                }
                ExpenseCard()
                    .environmentObject(viewModel)
                TransactionsView()
            }
            .padding()
        }
        .background(Color("BG").ignoresSafeArea())
        .fullScreenCover(isPresented: $viewModel.addNewExpense) {
            viewModel.clearData()
        } content: {
            NewExpense()
                .environmentObject(viewModel)
        }
        .overlay(alignment: .bottomTrailing) {
            AddButton()
        }
    }
    
    // Add new Expense Button
    @ViewBuilder
    func AddButton() -> some View {
        Button {
            viewModel.addNewExpense.toggle()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55, height: 55)
                .background {
                    Circle()
                        .fill(
                            .linearGradient(colors: [
                            Color("Gradient1"),
                            Color("Gradient2"),
                            Color("Gradient3"),
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
            
        }
        .padding()
    }
    
    // MARK: Transactions View
    @ViewBuilder
    func TransactionsView() -> some View {
        VStack(spacing: 15) {
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
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
