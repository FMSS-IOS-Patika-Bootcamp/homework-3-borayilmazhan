//
//  PhotosListEntity.swift
//  BootcampTaskk3
//
//  Created by Bora Yilmazhan on 23.09.2022.
//

import Foundation

struct PhotosCellViewModel {
    var title: String
    var url: String
    var thumbnailUrl: String
}

struct Photos: Codable {
    
    let title: String
    let url: String
    let thumbnailUrl: String
    
}
