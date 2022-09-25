//
//  AddNewToDoViewModel.swift
//  BootcampTaskk3
//
//  Created by Bora Yilmazhan on 25.09.2022.
//

import Foundation

class AddNewToDoViewModel {
    var todoItem : ToDo?
    var name: String
    var team: String
    var city: String
    var isEvaluated: Bool
    
    init(name: String, team: String, city: String, isEvaluated: Bool) {
        self.name = name
        self.city = city
        self.team = team
        self.isEvaluated = isEvaluated
    }
    
    
    func saveTask() {
        CoreDataManager.shared.saveToDo(name: self.name, team: self.team, city: self.city, completion: self.isEvaluated)
  }
    
    func uptadeTask(v:ToDo) {
        CoreDataManager.shared.updateToDo(todoItem: v, name: city, team: self.team, city: self.city, isEvaluated: self.isEvaluated)
       
  }

}
