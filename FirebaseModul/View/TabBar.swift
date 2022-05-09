//
//  TabBar.swift
//  FirebaseModul
//
//  Created by Вячеслав Квашнин on 16.06.2021.
//

import SwiftUI

struct TabBar: View {
    @ObservedObject var modelData: ModelData
    var body: some View {
        TabView {
            ArrView()
                .tabItem { Image(systemName: "house.fill") }
            
            CartView(modelData: modelData)
                .tabItem { Image(systemName: "cart.fill") }
        }
    }
}
