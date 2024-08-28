//
//  Interactor.swift
//  AdvaTaskUI
//
//  Created by Mahmoud on 28/08/2024.
//

import UIKit

// MARK: - PhotoDetailInteractorProtocol

protocol PhotoDetailInteractorProtocol: AnyObject {
    func loadImage(from url: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}

// MARK: - PhotoDetailInteractor

class PhotoDetailInteractor: PhotoDetailInteractorProtocol {
    
    // Loads an image from the provided URL and returns the result via completion handler
    func loadImage(from url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        // Ensure the URL is valid
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        // Start a data task to fetch the image
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle errors
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Ensure the data is valid and create an image from it
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(NSError(domain: "Invalid image data", code: 0, userInfo: nil)))
                return
            }
            
            // Return the image via the completion handler
            completion(.success(image))
        }.resume() // Start the data task
    }
}
