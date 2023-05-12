//
//  ToDo.swift
//  ToDoList
//
//  Created by Ion Sebastian Rodriguez Lara on 11/05/23.
//

import Foundation

struct ToDo: Equatable {
    let id = UUID()
    let title: String
    var isComplete: Bool
    let dueDate: Date
    let notes: String?
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        lhs.id == rhs.id
    }
    
    static func loadToDos() -> [ToDo]? {
        return nil
    }
    static func loadSampleToDos() -> [ToDo]{
        let toDo1 = ToDo(title: "To Do One", isComplete: true, dueDate: Date(), notes: "Notes 1")
        let toDo2 = ToDo(title: "To Do Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let toDo3 = ToDo(title: "To Do Three", isComplete: true, dueDate: Date(), notes: "Notes 3")
        return [toDo1, toDo2, toDo3]
    }
}
