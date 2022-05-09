//
//  CartView.swift
//  FirebaseModul
//
//  Created by Вячеслав Квашнин on 16.06.2021.
//

import SwiftUI

struct CartView: View {
    
    @ObservedObject var modelData : ModelData
    var body: some View {
        VStack {
            ForEach(modelData.itemsCart) { item in
                HStack {
                Text(item.name)
                }
                .contextMenu {
                    Button(action: {
                        let index = modelData.getIndex(item: item, isCartIndex: true)
//                        modelData.deleteItemCart(docId: index)
                    }, label: {
                        Text("Delete")
                    })
                }
            }

        }
    }
}
