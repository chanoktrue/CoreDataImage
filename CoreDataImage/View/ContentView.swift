//
//  ContentView.swift
//  CoreDataImage
//
//  Created by Thongchai Subsaidee on 14/4/2564 BE.
//

import SwiftUI

struct ContentView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)])
    private var products: FetchedResults<Product>
    
    @ObservedObject var coreDataVM = CoreDataViewModel()
    @State private var isPresent: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(products) { product in
                    HStack {
                        if let data = product.photo, let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(5)
                                .frame(width: 100, height: 100)
                                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 0)
                        }
                        Text(product.name ?? "")
                    }
                }
                .onDelete(perform: { indexSet in
                    coreDataVM.deleteProduct(indexSet: indexSet, products: products)
                })
            }
            .navigationTitle("Product")
            .navigationBarItems(trailing: Button(action: {
                addProduct()
            }, label: {
                Text("Add")
            }))
        }
        .sheet(isPresented: $isPresent, content: {
            AddProductView(isPresent: $isPresent)
        })
    }
    
    
    private func addProduct() {
        isPresent = true
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

