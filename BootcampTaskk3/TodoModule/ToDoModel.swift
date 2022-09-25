//
//  ToDoModel.swift
//  BootcampTaskk3
//
//  Created by Bora Yilmazhan on 25.09.2022.
//

import Foundation

struct ToDoModel {
    let name: String
    let team: String
    let city: String
    let isEvaluated: Bool

    
    init(name: String, team: String,city: String,isEvaluated: Bool) {
      self.name = name
      self.team = team
      self.city = city
      self.isEvaluated = isEvaluated

    }
    
    
}
