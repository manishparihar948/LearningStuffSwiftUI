//
//  HashableBootCamp.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 16.08.23.
//

import SwiftUI


// If you want explicit id then Uses Identifiable
/*
struct MyCustomModel: Identifiable {
    
    let id: UUID().uuidString
    let title: String
}
*/

// IF you dont want to use id then, Better to ues Hashable instead of Identifiable and create Hash function
struct MyCustomModel: Hashable {
    
    let title: String
    
    // To confirm a hashable, this model to have a hashable id create a hash with an unique id
    func hash(into hasher: inout Hasher) {
        // Customise the hash funtion further 
        hasher.combine(title)
    }
    
}

struct HashableBootCamp: View {
    
    let data : [MyCustomModel] = [MyCustomModel(title: "One"),
                                  MyCustomModel(title: "Two"),
                                   MyCustomModel(title: "Three"),
                                    MyCustomModel(title: "Four"),
                                     MyCustomModel(title: "Five"),
    ]
 
    var body: some View {
        VStack (spacing:30){
           
            
            ForEach(data, id: \.self){ item in
                Text(item.title)
                    .font(.headline)
            }
            
        }
    }
}

struct HashableBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableBootCamp()
    }
}
