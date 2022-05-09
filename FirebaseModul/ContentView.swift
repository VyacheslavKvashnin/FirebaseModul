//
//  ContentView.swift
//  FirebaseModul
//
//  Created by Вячеслав Квашнин on 16.06.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var modelData = ModelData()
    var body: some View {
        TabBar(modelData: modelData)
    }
}
