//
//  Item.swift
//  FirebaseModul
//
//  Created by Вячеслав Квашнин on 16.06.2021.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Item: Identifiable, Codable  {
 
    @DocumentID var id: String?
    var name: String
    var cost: Int
    var details: String
    var image: String
    var ratings: String
    
    // чтобы определить, добавлен ли он в корзину
    
    var isAdded: Bool = false
    var quantity: Int = 1
}
