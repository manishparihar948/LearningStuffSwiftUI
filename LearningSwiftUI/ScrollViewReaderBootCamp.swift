//
//  ScrollViewReader.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 14.08.23.
//

import SwiftUI

struct ScrollViewReaderBootCamp: View {
    
    @State var scrollToIndex: Int = 0
    @State var textFieldText: String = ""
    
    var body: some View {
        
        VStack {
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("Scroll Now") {
                withAnimation(.spring()){
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }
            
            ScrollView {
                // proxy basically reading size of the scroll view so its knows where each items are.
                ScrollViewReader { proxy in
                   /*
                    Button("Click Here TO GO TO #30"){
                        withAnimation(.spring()){
                            proxy.scrollTo(30, anchor: .center)
                            // anchor could be bottom, top or center
                        }
                    }
                    */
                    
                    ForEach(0..<50){ index in
                        Text("Text display item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { value in
                        withAnimation(.spring()){
                            proxy.scrollTo(value, anchor:nil)
                        }
                    }
                }
            }
        }
    }
}

struct ScrollViewReaderBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderBootCamp()
    }
}
