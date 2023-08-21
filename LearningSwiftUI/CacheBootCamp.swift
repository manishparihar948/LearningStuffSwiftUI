//
//  CacheBootCamp.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 21.08.23.
//

import SwiftUI

// Save temperorily into Cache
class CacheManager {
    // Making Singleton
    static let instance = CacheManager() // Singleton
    // Because we make init private it basically tell Xcode, we can only initialize a CacheManager within the class, which we initialize one down in another class
    private init() {}
    
    // create local cache
    var imageCache: NSCache<NSString, UIImage> = {
       let cache = NSCache<NSString, UIImage>() // When we store any kind of data in local cache its going to store it in the memory of the device, and we want the memory as low as possible.
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 mb
        return cache
    }()
    
    func add(image:UIImage, name:String) -> String {
        imageCache.setObject(image, forKey: name as NSString) // Casting as NSString
        return "Added to cache!"
    }
    
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from cache!"
    }
    
    func get(name:String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage : UIImage? = nil
    @Published var inforMsg : String = ""
    
    let imageName : String = "steve"
    let manager = CacheManager.instance

    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func savetoCache() {
        guard let image = startingImage else { return }
        inforMsg = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        inforMsg = manager.remove(name: imageName)
    }
    
    func getFromCache() {
        
        if let returnedImage = manager.get(name: imageName){
            cachedImage = returnedImage
            inforMsg = "Got image from Cache"
        } else {
            inforMsg = "Image not found in Cache"
        }
    }
}

struct CacheBootCamp: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200,height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
               
                Text(vm.inforMsg)
                    .font(.headline)
                    .foregroundColor(.purple)
                
                
                HStack {
                    
                    Button(action: {
                        vm.savetoCache()
                    }, label:  {
                        Text("Save to Cache")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    
                    Button(action: {
                        vm.removeFromCache()
                    }, label:  {
                        Text("Delete from Cache")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    })
                }
                
                Button(action: {
                    vm.getFromCache()
                }, label:  {
                    Text("Get from Cache")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                })
                
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200,height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                Spacer()
            }
            .navigationTitle("Cache BootCamp")
        }
    }
}

struct CacheBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        CacheBootCamp()
    }
}
