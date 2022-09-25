//
//  CoreDataManager.swift
//  BootcampTaskk3
//
//  Created by Bora Yilmazhan on 25.09.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()

    private init() {}
    
    func deleteTask(todo t: ToDo, completion: @escaping (Bool) -> Void) {
        let request: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", t.id!.uuidString)
        
        do {
            let context = persistentContainer.viewContext
            let result = try context.fetch(request)
            if result.count > 0 {
                let todo = result.first!
                context.delete(todo)
                saveContext()
                completion(true)
            }
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func completeTask(todo t: ToDo, completion: @escaping (Bool) -> Void) {
        let request: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", t.id!.uuidString)
        
        do {
            let result = try persistentContainer.viewContext.fetch(request)
            if result.count > 0 {
                let todo = result.first!
                todo.isEvaluated = true
                saveContext()
                completion(true)
            }
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func getAllTodos () -> [ToDo] {
        let request: NSFetchRequest<ToDo> = ToDo.fetchRequest()
//        let firstSort = NSSortDescriptor(key: #keyPath(ToDo.td_createdDate), ascending: false)
//        request.sortDescriptors = [firstSort]
        var todos = [ToDo]()
        
        do {
            todos = try persistentContainer.viewContext.fetch(request)
        } catch let err {
            print(err.localizedDescription)
        }
        
        return todos
    }
    
    func saveToDo(name: String, team: String,city: String, completion: Bool) {
        let todo = ToDo(context: persistentContainer.viewContext)
        todo.name = name
        todo.team = team
        todo.city = city
        todo.isEvaluated = completion
        todo.id = UUID()
        saveContext()
        //completion(true)
    }
    
    
    func updateToDo(todoItem: ToDo, name: String, team: String,city: String, isEvaluated: Bool){
        let manageContext = persistentContainer.viewContext
        todoItem.name = name
        todoItem.team = team
        todoItem.city = city
        todoItem.isEvaluated = isEvaluated
        
        do {
            if manageContext.hasChanges{
                try manageContext.save()
                print("Succesful.")
            }
        } catch  {
            print("Unsuccessful")
            debugPrint("Update error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BootcampTaskk3")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
