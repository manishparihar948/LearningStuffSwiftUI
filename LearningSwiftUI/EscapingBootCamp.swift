//
//  EscapingBootCamp.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 17.08.23.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    @Published var text: String = "Hello World"
    
    func getData() {
        /*
        let newData = downloadData()
        text = newData
         */
        
        /*
        downloadData2 { (returnedData) in
            text = returnedData
        }
        */
        
        /*
        downloadData3 { [weak self] (returnedData) in
            // We want this class to alive so we make strong reference to this class as self and completion handler to call after 2 seconds. We tell xcode we need this class to alive when we come back becauses of that we made strong reference, but we need to use weak self reference
                self?.text = returnedData
        }
        */
        
        /*
        downloadData4 { [weak self] (returnedResult) in
            self?.text = returnedResult.data
        }
        */
        
        
        downloadData5 { [weak self] (returnedResult) in
            self?.text = returnedResult.data
        }
         
    }
    
    // This is schronous code
    func downloadData() -> String {
        
        return "New Data"
    }
    
// Basics of a closure - Closure is Adding a function as a parameter into original function, so instead of returning this sting here, we are going to type a parameter called completionHandler and this will be of type and we are going to open the parenthesis using underscore lets call this data will be of type string close the parenthesis and then this function will return void
    func downloadData2(completionHandler: (_ data: String) -> ()) {
        completionHandler("Second New Data !!")
    }
    
// Void and () is same thing - Swift knows void and parenthesis is same
//    func doSomething(_ data: String) -> Void {
//        print(data)
//    }
    
    
// without @escaping - Shows error of Escaping closure captures non-escaping parameters "completionHandler"
// use of @escaping - it makes our code asyncronous
    func downloadData3(completionHandler: @escaping (_ data: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("Third New Data !!!")
        }
    }
    
    func downloadData4(completionHandler: @escaping (DownloadResult) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "Data Forth ...!")
            completionHandler(result)
        }
    }
    
    // This is Efficient Coding Standard
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "Data Five ...!")
            completionHandler(result)
        }
    }
    
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingBootCamp: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
    }
}

struct EscapingBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootCamp()
    }
}
