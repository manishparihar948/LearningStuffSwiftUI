//
//  DownloadWithCombine.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 18.08.23.
//

import SwiftUI
// Combine handle asynchronous events by combining event-processing operators
import Combine


struct PostModels : Identifiable, Codable {
    let userId : Int
    let id: Int
    let title: String
    let body: String
    
}

class DownloadWithCombineViewModel {
    
    @Published var posts : [PostModels] = []
    var cancellables = Set<AnyCancellable>()

    init() {
        getPost()
    }
    
    func getPost() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

        // 1. sign up for monthly subscription for package to be deliverd
        // 2. the company would make the package behind the scene
        // 3. receive the package at your front door
        // 4. make sure the box isnt damaged
        // 5. open and make sure the item is correct
        // 6. use the item
        // 7. cancellable at any time
        
        /*
        // 1. create the publisher
        URLSession.shared.dataTaskPublisher(for: url)
        // 2. subscribe the publisher on background thread
            .subscribe(on: DispatchQueue.global(qos: .background))
        // 3. receive on main thread
            .receive(on: DispatchQueue.main)
        // 4. tryMap (check that the data is good)
            .tryMap { (data, response) -> Data in
                
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                    }
                return data
            }
        // 5. decode (decide data into PostModels)
            .decode(type: [PostModels].self, decoder: JSONDecoder())
        // 6. sink (put the item into our app)
            .sink { (completion) in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
        // 7. store (cancel subscription if needed)
            .store(in: &cancellables)
         */
        
        URLSession.shared.dataTaskPublisher(for: url)
            //.subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap (handleOutput)
            .decode(type: [PostModels].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            })
            .store(in: &cancellables)
        
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
            }
        return output.data
    }
}

struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment:.leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.green)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

            }
        }
    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}
