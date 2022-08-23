//
//  NewExpense.swift
//  ExpenseTracker
//
//  Created by Дмитрий Спичаков on 23.08.2022.
//

import SwiftUI

struct NewExpense: View {
    
    @EnvironmentObject var viewModel: ExpenseViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 15) {
                
            }
        }
    }
}

struct NewExpense_Previews: PreviewProvider {
    static var previews: some View {
        NewExpense()
            .environmentObject(ExpenseViewModel())
    }
}
