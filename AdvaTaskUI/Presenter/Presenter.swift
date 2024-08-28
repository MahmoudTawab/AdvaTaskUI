//
//  Presenter.swift
//  AdvaTaskUI
//
//  Created by Mahmoud on 28/08/2024.
//

import UIKit
import Combine

// MARK: - ImageLoader

class ImageLoader: ObservableObject {
    
    // Published property to notify subscribers of state changes
    @Published var state: LoadingState = .loading
    
    // Enum representing the loading state of the image
    enum LoadingState {
        case loading          // Loading in progress
        case success(UIImage) // Successfully loaded image
        case failure          // Failed to load image
    }
    
    // Loads an image from the given URL string
    func load(from urlString: String) {
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            state = .failure
            return
        }
        
        // Start a data task to fetch the image
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Update the state on the main thread
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self.state = .success(image)
                } else {
                    self.state = .failure
                }
            }
        }.resume() // Start the data task
    }
}

