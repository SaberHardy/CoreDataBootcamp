//
//  CoreDataBooteApp.swift
//  CoreDataBoote
//
//  Created by MacBook on 09.07.2022.
//

import SwiftUI

@main
struct CoreDataBooteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
