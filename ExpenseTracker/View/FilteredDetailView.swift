//
//  FilteredDetailView.swift
//  ExpenseTracker
//
//  Created by Дмитрий Спичаков on 23.08.2022.
//

import SwiftUI

struct FilteredDetailView: View {
    
    @EnvironmentObject var viewModel: ExpenseViewModel
    @Environment(\.self) var env
    @Namespace var animation
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15.0) {
                HStack(spacing: 15) {
                    
                    // Back Button
                    Button {
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.backward.circle.fill")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                    
                    
                    Text("Transactions")
                        .font(.title.bold())
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        viewModel.showFilterView = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                }
                
                // Expense Card view for currently selected date
                ExpenseCard(isFilter: true)
                    .environmentObject(viewModel)
                
                CustomSegmentedControl()
                    .padding(.top)
                
                // Currently filtered date with amount
                VStack(spacing: 15.0) {
                    Text(viewModel.convertDateToString())
                        .opacity(0.7)
                    Text(viewModel.convertExpensesToCurrency(expenses: viewModel.expenses, type: viewModel.tabName))
                        .font(.title.bold())
                        .opacity(0.9)
                        .animation(.none, value: viewModel.tabName)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                }
                .padding(.vertical, 20)
                
                ForEach(viewModel.expenses.filter {
                    return $0.type == viewModel.tabName
                }) { expense in
                    TransactionsCardView(expense: expense)
                        .environmentObject(viewModel)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .background {
            Color("BG").ignoresSafeArea()
        }
        .overlay {
            FilterView()
        }
    }
    
    // Filter view
    @ViewBuilder
    func FilterView() -> some View {
        ZStack {
            Color.black
                .opacity(viewModel.showFilterView ? 0.25 : 0)
                .ignoresSafeArea()
            
            // filter date expenses array
            if viewModel.showFilterView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Start Date")
                        .font(.caption)
                        .opacity(0.7)
                    
                    DatePicker("", selection: $viewModel.startDate, in: Date.distantPast...Date(), displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                    
                    Text("End Date")
                        .font(.caption)
                        .opacity(0.7)
                        .padding(.top, 10)
                    
                    DatePicker("", selection: $viewModel.endDate, in: Date.distantPast...Date(), displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                }
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
                // Close Button
                .overlay(alignment: .topTrailing, content: {
                    Button {
                        viewModel.showFilterView = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.black)
                            .padding(5)
                    }
                })
                .padding()
            }
        }
        .animation(.easeInOut, value: viewModel.showFilterView)
    }
    
    // Custom segmented control
    @ViewBuilder
    func CustomSegmentedControl() -> some View {
        HStack(spacing: 0) {
            ForEach([ExpenseType.income, ExpenseType.expense], id: \.rawValue ) { tab in
                Text(tab.rawValue.capitalized)
                    .fontWeight(.semibold)
                    .foregroundColor(viewModel.tabName == tab ? .white : .black)
                    .opacity(viewModel.tabName == tab ? 1 : 0.7)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background {
                        if viewModel.tabName == tab {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(
                                    LinearGradient(colors: [
                                        Color("Gradient1"),
                                        Color("Gradient2"),
                                        Color("Gradient3"),
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            viewModel.tabName = tab
                        }
                    }
            }

        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
        }
    }
}

struct FilteredDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredDetailView()
            .environmentObject(ExpenseViewModel())
    }
}
