//
//  ContentView.swift
//  CoreDataBoote
//
//  Created by MacBook on 09.07.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    //    @FetchRequest(
    //        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntety.timestamp, ascending: true)],
    //        animation: .default)
    
    @FetchRequest(
        entity: FruitEntety.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntety.title, ascending: true)])
    
    var fruits: FetchedResults<FruitEntety>
    
    //    private var items: FetchedResults<FruitEntety>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(fruits) { fruit in
                    Text(fruit.title ?? "")
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Fruits")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    })
        }
    }
    
    private func addItem() {
        withAnimation {
            let newFruit = FruitEntety(context: viewContext)
            newFruit.title = "Orange"
            
            saveItems()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else { return }
            let fruitEntity = fruits[index]
            viewContext.delete(fruitEntity)
            
            saveItems()
        }
    }
    
    private func saveItems() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
