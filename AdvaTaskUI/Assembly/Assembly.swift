//
//  Assembly.swift
//  AdvaTaskUI
//
//  Created by Mahmoud on 28/08/2024.
//

import SwiftUI

// MARK: - Assembly

class PhotoDetailAssembly {
    static func assembleModule(for photo: Photo) -> some View {
        let presenter = PhotoDetailView(photo: photo)        
        return presenter
    }
}
