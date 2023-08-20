//
//  CustomPublishersAndSubscribers.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 20.08.23.
//

import SwiftUI

import Combine


class SubscribersViewModel: ObservableObject {
    
    @Published var count : Int = 0
    
    // we can cancel anytime
    //var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        
        addTextFieldSubscriber()
        
        addButtonSubscriber()
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
            //.assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] (isValid) in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
     // timer = Timer
            Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                // check self is valid
                guard let self = self else { return }
                self.count += 1
                
                /*
                // create cancellable
                if self.count >= 10 {
                    for item in self.cancellables {
                        item.cancel()
                    }
                }
                */
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
    
}

struct CustomPublishersAndSubscribers: View {
    
    @StateObject var vm = SubscribersViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            Text(vm.textIsValid.description)
            
            TextField("Type something here.....", text: $vm.textFieldText)
                .padding()
                .frame(height: 55)
                .background(Color.yellow)
                .cornerRadius(10)
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(vm.textFieldText.count < 1 ? 0.0 :
                                vm.textIsValid ? 0.0 : 1.0)
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                    .font(.headline)
                    .padding(.trailing)
                    
                    ,alignment: .trailing
                )
            
            Button(action: {}, label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            })
            
        }.padding()
    }
}

struct CustomPublishersAndSubscribers_Previews: PreviewProvider {
    static var previews: some View {
        CustomPublishersAndSubscribers()
    }
}
