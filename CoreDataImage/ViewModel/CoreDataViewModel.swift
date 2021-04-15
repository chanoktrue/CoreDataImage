//
//  CoreDataViewModel.swift
//  CoreDataImage
//
//  Created by Thongchai Subsaidee on 14/4/2564 BE.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    @Published var name: String = ""
    @Published var selectedImage: UIImage = UIImage()
    

    private func saveViewContext() {
        do{
            try viewContext.save()
        }catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
    
    func addProduct() {
        if self.name == "" {
            return
        }
        let product = Product(context: viewContext)
        product.name = self.name
        if let photoData = selectedImage.jpegData(compressionQuality: 0.1) {
            product.photo = photoData
        }
        saveViewContext()
    }
    
    func deleteProduct(indexSet: IndexSet, products: FetchedResults<Product>) {
        indexSet.map({products[$0]}).forEach { product in
            viewContext.delete(product)
            saveViewContext()
        }
    }
    
}
