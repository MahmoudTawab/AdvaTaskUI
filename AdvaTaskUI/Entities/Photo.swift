//
//  Photo.swift
//  AdvaTaskUI
//
//  Created by Mahmoud on 28/08/2024.
//

import SwiftUI

// MARK: - Entities Photo

struct Photo: Codable, Identifiable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
