//
//  PhotoListViewModelTests.swift
//  AdvaTaskUITests
//
//  Created by Mahmoud on 28/08/2024.
//

import XCTest
@testable import AdvaTaskUI

class PhotoListViewModelTests: XCTestCase {
    
    var viewModel: PhotoListViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUpWithError() throws {
        mockNetworkService = MockNetworkService()
        viewModel = PhotoListViewModel(networkService: mockNetworkService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockNetworkService = nil
    }

    func testLoadPhotosSuccess() throws {
        let photos = [
            Photo(albumId: 1, id: 1, title: "Test Photo 1", url: "https://example.com/photo1.jpg", thumbnailUrl: "https://example.com/photo1_thumbnail.jpg")
        ]
        mockNetworkService.mockPhotos = photos
        
        viewModel.loadPhotos()
        
        XCTAssertEqual(viewModel.photos.count, 1)
        XCTAssertEqual(viewModel.photos.first?.title, "Test Photo 1")
    }
    
    func testLoadPhotosFailure() throws {
        mockNetworkService.shouldFail = true
        
        viewModel.loadPhotos()
        
        XCTAssertEqual(viewModel.photos.count, 0)
    }
}

class MockNetworkService: NetworkService {
    var mockPhotos: [Photo] = []
    var shouldFail = false
    
    override func fetchData<T>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if shouldFail {
            completion(.failure(NSError(domain: "Test Error", code: 0, userInfo: nil)))
        } else {
            completion(.success(mockPhotos as! T))
        }
    }
}
