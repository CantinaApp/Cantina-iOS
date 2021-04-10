//
//  ImageView.swift
//  Cantina
//
//  Created by Andrew Davis on 3/30/21.
//

import Combine
import Foundation
import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: URL) {
        imageLoader = ImageLoader(imageURL: url)
    }
    
    var body: some View {
        Image(uiImage: UIImage(data: imageLoader.data) ?? UIImage())
            .resizable()
    }
}

class ImageLoader: ObservableObject {
    
    @Published var data = Data()
    
    init(imageURL: URL) {
        // URL:Image cache
        let cache = URLCache.shared
        
        let request = URLRequest(url: imageURL, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60.0)
        
        if let data = cache.cachedResponse(for: request)?.data {
            // Get image from cache
            self.data = data
        } else {
            // Get image from download
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response {
                let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.data = data
                    }
                }
            })
            task.resume()
        }
    }
}
