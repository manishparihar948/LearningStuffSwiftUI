//
//  MultiThreadingBootCamp.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 16.08.23.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray : [String] = []
    
    func fetchData() {
        // This is in Main Thread Now
        // let newData = downloadData()
        // dataArray = newData
        
        // Background Thread
        DispatchQueue.global(qos: .background).async {
            
            let newData = self.downloadData()
            
            print("Check  1: \(Thread.isMainThread)")
            print("Check  2: \(Thread.current)")
            
            
            // If we get warning in Purple Color that we need to display array in main thread not in background thread.so use DispactchQueue.main
            DispatchQueue.main.async {
                self.dataArray = newData
            }
        }
    }
    
   private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
}

struct MultiThreadingBootCamp: View {
    
  @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        
        ScrollView {
            LazyVStack(spacing:10) {
                Text("Load Data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct MultiThreadingBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        MultiThreadingBootCamp()
    }
}
