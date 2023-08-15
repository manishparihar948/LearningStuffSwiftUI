//
//  GeometryReaderBootCamp.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 15.08.23.
//

import SwiftUI

struct GeometryReaderBootCamp: View {
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    
    var body: some View {
       
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack{
                ForEach(0..<20){ index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(Angle(degrees: getPercentage(geo: geometry) * 40), axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        })
        
        
        
        /*
        GeometryReader { geometry in
            HStack (spacing:0){
                Rectangle()
                    .fill(Color.red)
                    // If we develop app for Portrait mode then we will use UIScreen.main.bounds.width
                
                    // And if we have landscape mode then we will use Geometry Reader
                    //.frame(width: UIScreen.main.bounds.width * 0.6666)
                    .frame(width: geometry.size.width * 0.6666)
                
                Rectangle().fill(Color.blue)
                
            }
            .ignoresSafeArea()
        }
        */
    }
}

struct GeometryReaderBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBootCamp()
    }
}
