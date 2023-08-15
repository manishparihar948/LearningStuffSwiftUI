//
//  MultipleSheetBootCamp.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 15.08.23.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title : String
}

// 1 - use a binding
// 2 - use multipe .sheet
// 3 - use $item

struct MultipleSheetBootCamp: View {
    
    @State var selectedModel  : RandomModel? = nil
 
    var body: some View {
        ScrollView {
            VStack (spacing:20) {
                ForEach(0..<50){ index in
                    Button("Button \(index)") {
                        selectedModel = RandomModel(title: "\(index)")
                    }
                }
            }
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model) // This apporach is good for user profile we have to change model with user profile
            }
        }
    }
}

struct NextScreen: View {
    
    var selectedModel : RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}



struct MultipleSheetBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetBootCamp()
    }
}
