//
//  PostListEntity.swift
//  BootcampTaskk3
//
//  Created by Bora Yilmazhan on 22.09.2022.
//

import Foundation

struct PostCellViewModel {
    var title: String?
    var desc: String?
}

struct Post: Decodable {
    var userId: Int
    var id: Int
    var title:String
    var body:String
}
