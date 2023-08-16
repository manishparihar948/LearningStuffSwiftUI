//
//  ArraysBootCamp.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 16.08.23.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray : [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        // SORT
        /*
        filteredArray = dataArray.sorted { (user1, user2) -> Bool in
            return user1.points > user2.points
        }
        */
        /*
        // Use above or use this
        filteredArray = dataArray.sorted(by: {$0.points < $1.points})
        */
        
        // FILTER
        /*
        filteredArray = dataArray.filter({ (user) -> Bool in
            return user.isVerified
        })
        */
        // or use below code
        /*
        filteredArray = dataArray.filter({$0.isVerified})
        */
        
        // MAP
        /*
//        mappedArray = dataArray.map({ (user) -> String in
//            return user.name
//        })
        
//        mappedArray = dataArray.map({$0.name})
        
//        mappedArray = dataArray.map({(user) -> String? in
//            return user.name ?? "Error"
//        })
        
//        mappedArray = dataArray.compactMap({ (user) -> String? in
//            return user.name
//        })
//
         */
        // mappedArray = dataArray.compactMap({ $0.name })
        /*
        let sort = dataArray.sorted(by: {$0.points > $1.points })
        let filter = dataArray.filter({ $0.isVerified })
        let map = dataArray.compactMap({ $0.name })
        */
        
        // This is high tech filtering
        mappedArray = dataArray
                        .sorted(by: {$0.points > $1.points })
                        .filter({ $0.isVerified })
                        .compactMap({ $0.name })
        
        
    }
    
    
    func getUsers() {
        let users1 = UserModel(name: "Nick", points: 15, isVerified: true)
        let users2 = UserModel(name: "Mac", points: 52, isVerified: false)
        let users3 = UserModel(name: "IOS", points: 25, isVerified: true)
        let users4 = UserModel(name: "Jack", points: 55, isVerified: true)
        let users5 = UserModel(name: nil, points: 65, isVerified: false)
        let users6 = UserModel(name: "Emily", points: 35, isVerified: true)
        let users7 = UserModel(name: "Neo", points: 12, isVerified: false)
        let users8 = UserModel(name: "Jio", points: 45, isVerified: true)
        let users9 = UserModel(name: nil, points: 56, isVerified: false)
        let users10 = UserModel(name: "Hann", points: 85, isVerified: true)
        
        self.dataArray.append(contentsOf: [
        users1,
        users2,
        users3,
        users4,
        users5,
        users6,
        users7,
        users8,
        users9,
        users10
        ])
    }
}

struct ArraysBootCamp: View {
    @StateObject var vm = ArrayModificationViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing:10){
                ForEach(vm.mappedArray, id:\.self){ name in
                    Text(name)
                        .font(.title)
                }
                /*
                ForEach(vm.filteredArray){ user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        HStack {
                            Text("Points: \(user.points)")
                            Spacer()
                            if user.isVerified {
                                Image(systemName: "flame.fill")
                            }
                        }
                    }
                }
                */
                .foregroundColor(.white)
                .padding()
                .background(Color.blue.cornerRadius(10))
                .padding(.horizontal)
            }
        }
    }
}

struct ArraysBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootCamp()
    }
}
