//
//  MagnificationGesture.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 14.08.23.
//

import SwiftUI

struct MagnificationGestureLearning: View {
    @State var currentAmount : CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.title)
            .padding(40)
            .background(Color.red.cornerRadius(10))
            .scaleEffect( 1 + currentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        currentAmount = value - 1
                    }
                    .onEnded {value in
                        lastAmount += currentAmount
                        currentAmount = 0
                    }
            )
    }
}

struct MagnificationGesture_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureLearning()
    }
}
