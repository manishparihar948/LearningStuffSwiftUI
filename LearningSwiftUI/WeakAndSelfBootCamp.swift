//
//  WeakAndSelfBootCamp.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 16.08.23.
//

import SwiftUI

struct WeakAndSelfBootCamp: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate",destination: WeakSelfSecondScreen())
                .navigationTitle("Screen 1")
            
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10)
            ,alignment: .topTrailing)
        )
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    var body: some View {
        Text("Second Screen")
            .font(.largeTitle)
            .foregroundColor(.red)
        
        if let data = vm.data {
            Text(data)
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    @Published var data: String? = nil
    
    init() {
        print("Initialize Now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
       
        print("DeInitialize Now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        /*
        DispatchQueue.global().async {
            // With this self the Class WeakSelfSecondScreenViewModel need to stay Alive, because we need that self when we come back.
            self.data = "New Data!!!!!"
        }
         */
        
        
        // Here count keep increasing when we click navigate the problem is ViewModel is keep alive multiple times, actually they dont need to be alive. this is not efficient
        // That is the reason we need to make it weak self
        DispatchQueue.main.asyncAfter(deadline:.now() + 500) { [weak self] in
            self?.data = "New Data!!!!!"

        }
    }
}

struct WeakAndSelfBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        WeakAndSelfBootCamp()
    }
}
