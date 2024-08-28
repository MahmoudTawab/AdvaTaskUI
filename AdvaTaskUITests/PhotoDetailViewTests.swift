//
//  PhotoDetailViewTests.swift
//  AdvaTaskUITests
//
//  Created by Mahmoud on 28/08/2024.
//

import XCTest
@testable import AdvaTaskUI

class PhotoDetailViewTests: XCTestCase {
    
    func testImageLoaderSuccess() throws {
        let imageLoader = ImageLoader()
        let expectation = XCTestExpectation(description: "Image loaded successfully")
        
        imageLoader.load(from: "https://example.com/photo.jpg")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if case .success(_) = imageLoader.state {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(imageLoader.state.isSuccess)
    }
    
    func testImageLoaderFailure() throws {
        let imageLoader = ImageLoader()
        let expectation = XCTestExpectation(description: "Image failed to load")
        
        imageLoader.load(from: "https://invalid-url.com/photo.jpg")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if case .failure = imageLoader.state {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(imageLoader.state.isFailure)
    }
}

extension ImageLoader.LoadingState {
    var isSuccess: Bool {
        if case .success(_) = self {
            return true
        }
        return false
    }
    
    var isFailure: Bool {
        if case .failure = self {
            return true
        }
        return false
    }
}
