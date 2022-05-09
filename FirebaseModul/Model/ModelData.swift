//
//  ModelData.swift
//  FirebaseModul
//
//  Created by Вячеслав Квашнин on 16.06.2021.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class ModelData: ObservableObject {
    
    @Published var items: [Item] = []
    @Published var itemsCart: [Item] = []
    
    init() {

        let ref = Firestore.firestore()

        ref.collection("Items")
            .addSnapshotListener { (snap, err) in

                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }

                for i in snap!.documentChanges {

                    if i.type == .added {

                        let id = i.document.documentID
                        let cost = i.document.get("cost") as! NSNumber
                        let name = i.document.get("name") as! String
                        let details = i.document.get("details") as! String
                        let image = i.document.get("image") as! String
                        let ratings = i.document.get("ratings") as! String

                        self.items.append(Item(id: id,name: name, cost: Int(truncating: cost), details: details, image: image, ratings: ratings))

                    }
                }
            }
        
        ref.collection("ItemsCartAdd")
            .addSnapshotListener { (snap, err) in

                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }

                for i in snap!.documentChanges {

                    if i.type == .added {

                        let id = i.document.documentID
                        let cost = i.document.get("cost") as! NSNumber
                        let name = i.document.get("name") as! String
                        let details = i.document.get("details") as! String
                        let image = i.document.get("image") as! String
                        let ratings = i.document.get("ratings") as! String

                        self.itemsCart.append(Item(id: id,name: name, cost: Int(truncating: cost), details: details, image: image, ratings: ratings))

                    }
                    
                    if i.type == .removed {
                        
                        let id = i.document.documentID
                        
                        for i in 0..<self.itemsCart.count {
                            if self.itemsCart[i].id == id {
                                self.itemsCart.remove(at: i)
                                return
                            }
                        }
                    }
                }
            }
    }
    
//    func fetchData() {
//
//        let db = Firestore.firestore()
//
//        db.collection("Items").getDocuments { (shap, err) in
//
//            guard let itemData = shap else {return}
//
//            self.items = itemData.documents.compactMap({ (doc) -> Item? in
//
//                let id = doc.documentID
//                let name = doc.get("name") as! String
//                let cost = doc.get("cost") as! NSNumber
//                let ratings = doc.get("ratings") as! String
//                let image = doc.get("image") as! String
//                let details = doc.get("details") as! String
//
//                return Item(id: id, name: name, cost: Int(truncating: cost), details: details, image: image, ratings: ratings)
//            })
//        }
//    }
    
    func fetchDataCart() {
        
        let db = Firestore.firestore()
        
        db.collection("ItemsCartAdd").getDocuments { (shap, err) in
            
            guard let itemData = shap else {return}
            
            self.itemsCart = itemData.documents.compactMap({ (doc) -> Item? in
                
                let id = doc.documentID
                let name = doc.get("name") as! String
                let cost = doc.get("cost") as! NSNumber
                let ratings = doc.get("ratings") as! String
                let image = doc.get("image") as! String
                let details = doc.get("details") as! String
                
                return Item(id: id, name: name, cost: Int(truncating: cost), details: details, image: image, ratings: ratings)
            })
        }
    }
    
    let ref = Firestore.firestore()
    
    func addItem(message: Item, completion: @escaping (Bool) -> ()) {
        
        do {
            let _ = try ref.collection("ItemsCartAdd").addDocument(from: message) { (error) in
                
                if error != nil {
                    completion(false)
                    return
                }
                completion(true)
            }
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    func addToCart(item: Item) {
        
        items[getIndex(item: item, isCartIndex: false)].isAdded = !item.isAdded
        
        if item.isAdded {
            
//            let index = getIndex(item: item, isCartIndex: false)
            ref.collection("ItemsCartAdd").document(item.id!).delete()
            
            return
        }
        addItem(message: item) { (status) in }
    }
    
//    func deleteItemCart(docId: Int) {
//        ref.collection("ItemsCartAdd")
//            .document(itemsCart[docId].id!)
//            .delete { (error) in
//                if error != nil {
//                    return
//                }
//                self.itemsCart.remove(at: docId)
//            }
//    }
    
    func getIndex(item: Item, isCartIndex: Bool) -> Int {
        
        let index = items.firstIndex { (item1) -> Bool in
            
            return item.id == item1.id
        } ?? 0
        
        let cartIndex = self.itemsCart.firstIndex { (item1) -> Bool in
            
            return item.id == item1.id
        } ?? 0
        
        return isCartIndex ? cartIndex : index
    }
}

