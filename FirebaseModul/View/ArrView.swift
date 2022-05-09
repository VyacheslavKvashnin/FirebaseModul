//
//  ArrView.swift
//  FirebaseModul
//
//  Created by Вячеслав Квашнин on 16.06.2021.
//

import SwiftUI

struct ArrView: View {
    
    @ObservedObject var modelData = ModelData()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack {
                
                ForEach(modelData.items) { item in
                    HStack {
                    Text(item.name)
                        
                Spacer()
                        
                    Button(action: {
                        modelData.addToCart(item: item)
                    }, label: {
                        Image(systemName: item.isAdded ? "cart" : "cart.fill")
                    })
                    }
                    .padding()
                }
            }
        }
    }
}

