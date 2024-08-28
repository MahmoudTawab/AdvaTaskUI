//
//  PhotoListView.swift
//  AdvaTaskUI
//
//  Created by Mahmoud on 28/08/2024.
//

import SwiftUI
import Combine

// MARK: - PhotoListView

struct PhotoListView: View {
    @StateObject private var viewModel = PhotoListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                // Display photos
                ForEach(viewModel.photos) { photo in
                    NavigationLink(destination: PhotoDetailAssembly.assembleModule(for: photo)) {
                        PhotoRow(photo: photo)
                    }
                }
                
                // Loading indicator
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
                
                // Load More button
                if !viewModel.isLoading && viewModel.hasMorePhotos {
                    HStack {
                        Spacer()
                        Button("Load More") {
                            viewModel.loadMorePhotos()
                        }
                        Spacer()
                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle("Photo Gallery")
            .onAppear {
                viewModel.loadPhotos()
            }
        }
    }
}
