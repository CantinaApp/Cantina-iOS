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
    @State var image: UIImage = UIImage()
    
    init(url: URL) {
        imageLoader = ImageLoader(url: url)
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onReceive(imageLoader.dataPublisher) { (data) in
                self.image = UIImage(data: data) ?? UIImage()
            }
    }
}

class ImageLoader: ObservableObject {
    var dataPublisher = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            dataPublisher.send(data)
        }
    }
    
    init(url: URL) {
        // Asynchronously get image from url
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
