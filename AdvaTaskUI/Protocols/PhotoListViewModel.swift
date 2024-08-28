//
//  PhotoListViewModel.swift
//  AdvaTaskUI
//
//  Created by Mahmoud on 28/08/2024.
//

import SwiftUI
import Combine

// MARK: - PhotoListViewModel
import Foundation

// MARK: - PhotoListViewModel

class PhotoListViewModel: ObservableObject {
    
    // Published properties to update the view
    @Published var photos: [Photo] = []
    @Published var isLoading = false
    @Published var hasMorePhotos = true
    
    private var currentPage = 1
    private let networkService: NetworkService
    
    // Initializer with a default NetworkService instance
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    // Loads photos from the network
    func loadPhotos() {
        // Prevent multiple simultaneous requests
        guard !isLoading else { return }
        isLoading = true
        
        // URL for fetching photos with pagination
        let urlString = "https://jsonplaceholder.typicode.com/photos?_page=\(currentPage)&_limit=10"
        
        // Fetch photos using the network service
        networkService.fetchData(from: urlString) { [weak self] (result: Result<[Photo], Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let newPhotos):
                    if newPhotos.isEmpty {
                        // No more photos to load
                        self.hasMorePhotos = false
                    } else {
                        // Append new photos and increment the page
                        self.photos.append(contentsOf: newPhotos)
                        self.currentPage += 1
                    }
                case .failure(let error):
                    // Handle error (e.g., show an error message)
                    print("Failed to load photos: \(error)")
                }
            }
        }
    }
    
    // Loads more photos if there are more to fetch
    func loadMorePhotos() {
        guard hasMorePhotos else { return }
        loadPhotos()
    }
}
