//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Дмитрий Спичаков on 21.08.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
