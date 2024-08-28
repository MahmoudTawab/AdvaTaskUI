//
//  NetworkService.swift
//  AdvaTaskUI
//
//  Created by Mahmoud on 28/08/2024.
//


import Foundation

// MARK: - NetworkService
/// A service class responsible for fetching data from a given URL and decoding it.
class NetworkService {
    
    /// Fetches data from a specified URL and decodes it into a model of type T.
    ///
    /// - Parameters:
    ///   - urlString: The URL string from which to fetch data.
    ///   - completion: A closure to be called with the result of the fetch operation.
    ///     - success: Contains the decoded model of type T.
    ///     - failure: Contains an error if the fetch or decoding fails.
    func fetchData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        // Ensure the URL string is valid
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        // Create a data task to fetch data from the URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Handle any errors that occurred during the request
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Ensure that data was received
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            // Attempt to decode the data into the expected model type
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
            
        }.resume() // Start the data task
    }
}
