//
//  TypeAliasBootCamp.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 16.08.23.
//

import SwiftUI

struct MovieModel {
    let title:String
    let director:String
    let count:Int
}

/*
struct TVModel {
    let title:String
    let director:String
    let count:Int
}
*/

// Typealias basically creating new name for an existing type
typealias TVModel = MovieModel

struct TypeAliasBootCamp: View {
    
    // @State var item: MovieModel = MovieModel(title: "Title", director: "Joe", count: 5)
    
    @State var item: TVModel = TVModel(title: "TV Title", director: "Emily", count: 10)
    
    var body: some View {
        VStack(spacing:20) {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

struct TypeAliasBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        TypeAliasBootCamp()
    }
}
