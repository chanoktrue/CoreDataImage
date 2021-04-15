//
//  AddProductView.swift
//  CoreDataImage
//
//  Created by Thongchai Subsaidee on 14/4/2564 BE.
//

import SwiftUI

struct AddProductView: View {
    
    @ObservedObject var coreDataVM = CoreDataViewModel()
    @Binding var isPresent: Bool
    
    @State var isImagePicker: Bool = false
    
    var body: some View {
        VStack (alignment: .leading){
            
            HStack() {
                Spacer()
                Text("Add Product")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                Spacer()
            }
                
            Spacer()
            
            Text("First name")
            TextField("Name:", text: $coreDataVM.name)
                .padding()
            
            Spacer()
            
            HStack{
                Spacer()
                Image(systemName: "camera.circle.fill")
                    .renderingMode(.template)
                    .foregroundColor(.blue)
                    .font(.system(size: 100))
                    .onTapGesture {
                        self.isImagePicker = true
                    }
                Spacer()
            }
            Spacer()
                
            HStack {
                Spacer()
                Image(uiImage: coreDataVM.selectedImage)
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                Spacer()
            }
            Spacer()
            
            Button(action: {
                isPresent = false
                coreDataVM.addProduct()
            }, label: {
                Text("Save")
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            
        }
        .padding()
        .sheet(isPresented: $isImagePicker, content: {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $coreDataVM.selectedImage)
        })
    }
    
    func addProduct() {
        
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView(isPresent: .constant(false))
    }
}
