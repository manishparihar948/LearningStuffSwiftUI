//
//  CoreDataBootCamp.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 16.08.23.
//

import SwiftUI
import CoreData

// View - UI
// Moddel - data point
// ViewModel - manages the data for a view

// We can not save Image or color or audio or video file directly into core data we have to use Binary Data for that

class CoreDataModel: ObservableObject {
    
    let container: NSPersistentContainer
    
    @Published var savedEntities : [FruitEntity] = []
    
    init() {
       container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { (description, error) in

            if let error = error {
                print("Error Loading Core Data. \(error)")
            } else {
                print("Successfully Loaded Core Data!")
            }
        }
        
        fetchFruits()
    }
    
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
                
        do {
         savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addFruit(text:String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet){
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        
        saveData()
    }
    
    func updateFruit(entity:FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "waow"
        entity.name = newName
        saveData()
    }
    
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}

struct CoreDataBootCamp: View {
    
    @StateObject var vm : CoreDataModel = CoreDataModel()
    @State var textFieldText:String = ""
    
    var body: some View {
        NavigationView {
            VStack (spacing:20){
                TextField("Add fruit here..:",text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding(.horizontal)
                
                
                Button (action: {
                    guard !textFieldText.isEmpty else { return }
                    vm.addFruit(text: textFieldText)
                    textFieldText = ""
                }, label: {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.green)
                        .cornerRadius(10)
                })
                .padding(.horizontal)
                
                List {
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "")
                            .onTapGesture {
                                vm.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}

struct CoreDataBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootCamp()
    }
}
