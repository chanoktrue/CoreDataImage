//
//  CoreDataImageApp.swift
//  CoreDataImage
//
//  Created by Thongchai Subsaidee on 14/4/2564 BE.
//

import SwiftUI

@main
struct CoreDataImageApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
