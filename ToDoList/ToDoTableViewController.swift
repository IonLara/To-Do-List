//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Ion Sebastian Rodriguez Lara on 11/05/23.
//

import UIKit

class ToDoTableViewController: UITableViewController, CellDelegate{
    func checkMarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var toDo = toDos[indexPath.row]
            toDo.isComplete.toggle()
            toDos[indexPath.row] = toDo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(toDos)
        }
    }
    

    var toDos = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedToDos = ToDo.loadToDos() {
            toDos = savedToDos
        } else {
            toDos = ToDo.loadSampleToDos()
        }
    }
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "save Unwind" else {return}
        let source = segue.source as! ToDoDetailTableViewController
        if let toDo = source.toDo {
            if let firstIndex = toDos.firstIndex(of: toDo) {
                toDos[firstIndex] = ToDo(title: source.titleTextField.text!, isComplete: source.isCompleteButton.isSelected, dueDate: source.dueDatePicker.date, notes: source.notesTextView.text)
                tableView.reloadRows(at: [IndexPath(row: firstIndex, section: 0)], with: .automatic)
            }
        } else {
            let toDo = ToDo(title: source.titleTextField.text!, isComplete: source.isCompleteButton.isSelected, dueDate: source.dueDatePicker.date, notes: source.notesTextView.text)
            let newIndexPath = IndexPath(row: toDos.count, section: 0)
            toDos.append(toDo)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        ToDo.saveToDos(toDos)
    }
    
    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> ToDoDetailTableViewController? {
        let detailController = ToDoDetailTableViewController(coder: coder)
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
            return detailController
        }
        tableView.deselectRow(at: indexPath, animated: true)
        detailController?.toDo = toDos[indexPath.row]
        return detailController
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "To Do Cell", for: indexPath) as! ToDoCell
        
        let toDo = toDos[indexPath.row]
        cell.titleLabel?.text = toDo.title
        cell.isCompleteButton.isSelected = toDo.isComplete
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(toDos)
        }
    }
}
