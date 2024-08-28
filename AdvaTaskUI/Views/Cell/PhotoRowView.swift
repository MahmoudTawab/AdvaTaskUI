//
//  PhotoRowView.swift
//  AdvaTaskUI
//
//  Created by Mahmoud on 28/08/2024.
//

import SwiftUI
import SDWebImageSwiftUI

// MARK: - PhotoRow

struct PhotoRow: View {
    let photo: Photo
    
    var body: some View {
        HStack {
            // Animated image with placeholder
            AnimatedImage(url: URL(string: photo.thumbnailUrl), placeholderImage: UIImage(systemName: "photo"))
                .transition(.fade)
                .resizable()
                .scaledToFit()
                .tint(Color.white)
                .frame(width: 80, height: 80)
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // Title text with padding
            Text(photo.title)
                .padding(.leading, 10)
        }
    }
}

