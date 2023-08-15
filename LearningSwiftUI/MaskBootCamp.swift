//
//  MaskBootCamp.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 15.08.23.
//


// 1. We basically add five bars in first layer
// 2. Rectangle on Top
// 3. We Mask the rectangle to the bottom layer to the start layer
// 4. Now we animating rectangle on top so that it goes from smaller to larger

import SwiftUI

struct MaskBootCamp: View {
    
    @State var rating: Int = 0
    
    var body: some View {
        VStack {
            starsView
                .overlay (overlayView.mask(starsView))
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment:.leading) {
                // Keep Rectangle on Top
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(rating >= index ? Color.yellow : Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index

                        }
                    }
            }
        }
    }
}

struct MaskBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        MaskBootCamp()
    }
}
