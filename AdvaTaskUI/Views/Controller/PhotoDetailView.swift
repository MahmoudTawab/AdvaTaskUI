//
//  PhotoDetailView.swift
//  AdvaTaskUI
//
//  Created by Mahmoud on 28/08/2024.
//

import SwiftUI

// MARK: - PhotoDetailView

struct PhotoDetailView: View {
    // The photo to be displayed
    let photo: Photo
    
    // State to manage the zoomable scroll view
    @State private var viewState = ViewState()
    // State object to handle image loading
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        GeometryReader { geometry in
            // ZoomableScrollView to allow zooming and scrolling
            ZoomableScrollView(
                viewState: $viewState,
                contentSize: geometry.size,
                content: {
                    imageView
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            )
            .edgesIgnoringSafeArea(.all) // Extend the view to edges
            .background(Color.black.opacity(0.8)) // Dark background for better visibility
            .onAppear {
                // Load the image when the view appears
                imageLoader.load(from: photo.url)
            }
        }
    }
    
    @ViewBuilder
    private var imageView: some View {
        // Switch between different image states
        switch imageLoader.state {
        case .loading:
            // Placeholder image while loading
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .tint(Color.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 50)
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        case .failure:
            // Error image if loading fails
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.red)
        case .success(let image):
            // Display the successfully loaded image
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
