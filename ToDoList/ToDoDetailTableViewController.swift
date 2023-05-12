//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by Ion Sebastian Rodriguez Lara on 12/05/23.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {
    
    var isDatePickerHidden = true
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDatePicker.date = Date().addingTimeInterval(24 * 60 * 60)
        updateSaveButton()
        updateDateLabel(date: dueDatePicker.date)
    }
    
    func updateSaveButton() {
        let state = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = state
    }
    func updateDateLabel(date: Date) {
        dueDateLabel.text = date.formatted(.dateTime.month(.defaultDigits) .day().year(.twoDigits) .hour().minute())
    }
    @IBAction func titleTextChanged(_ sender: UITextField) {
        updateSaveButton()
    }
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = true
    }
    @IBAction func dueDateChanged(_ sender: UIDatePicker) {
        updateDateLabel(date: sender.date)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case [1,1] where isDatePickerHidden == true:
            return 0
        case [2,0]:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case [1,1]:
            return 216
        case [2,0]:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == [1,0] {
            isDatePickerHidden.toggle()
            updateDateLabel(date: dueDatePicker.date)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}
