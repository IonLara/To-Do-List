//
//  ToDo.swift
//  ToDoList
//
//  Created by Ion Sebastian Rodriguez Lara on 11/05/23.
//

import Foundation

struct ToDo: Equatable, Codable {
    let id : UUID
    let title: String
    var isComplete: Bool
    let dueDate: Date
    let notes: String?
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
    
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        lhs.id == rhs.id
    }
    
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: archiveURL) else {return nil}
        let decoder = PropertyListDecoder()
        return try? decoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    static func saveToDos(_ toDos: [ToDo]) {
        let encoder = PropertyListEncoder()
        let coded = try? encoder.encode(toDos)
        try? coded?.write(to: archiveURL, options:  .noFileProtection)
    }
    static func loadSampleToDos() -> [ToDo]{
        let toDo1 = ToDo(title: "To Do One", isComplete: true, dueDate: Date(), notes: "Notes 1")
        let toDo2 = ToDo(title: "To Do Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let toDo3 = ToDo(title: "To Do Three", isComplete: true, dueDate: Date(), notes: "Notes 3")
        return [toDo1, toDo2, toDo3]
    }
    init(title: String, isComplete: Bool, dueDate: Date, notes: String?) {
        self.id = UUID()
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
}
