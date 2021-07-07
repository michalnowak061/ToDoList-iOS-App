//
//  AddViewController.swift
//  ToDoList
//
//  Created by Michał Nowak on 06/07/2021.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    // MARK: -- Private variable's
    private var model: TasksDataManager!
    
    private var taskName: String?
    
    private var selectedPriority: Priority!
    
    // MARK: -- IBOutlet's
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet var priorityButtons: [UIButton]!
    
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: -- Override function's
    override func loadView() {
        super.loadView()
        self.setup()
    }
    
    // MARK: -- Private function's
    private func check() {
        if self.nameTextField.text?.isEmpty ?? true {
            self.addButton.isEnabled = false
        } else {
            self.addButton.isEnabled = true
        }
    }
    
    private func setup() {
        self.setupPriorityButtons()
        self.setupAddButton()
    }
    
    private func setupPriorityButtons() {
        for button in self.priorityButtons {
            button.layer.cornerRadius = 10
            button.backgroundColor = #colorLiteral(red: 0.703534755, green: 0.7368400091, blue: 0.7732545685, alpha: 1)
            button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        self.setPriorityButtonBackgroundColor(atIndex: 0, color: Priority.low.color)
        self.selectedPriority = .low
    }
    
    private func setupAddButton() {
        self.addButton.layer.cornerRadius = 10
        self.addButton.backgroundColor = #colorLiteral(red: 0.7128377083, green: 0.307490105, blue: 0.9686274529, alpha: 1)
        self.addButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func setPriorityButtonBackgroundColor(atIndex index: Int, color: UIColor) {
        let range = 0 ..< self.priorityButtons.count
        let filteredIndexes = range.filter { currentIndex in
            return currentIndex != index
        }
        
        let button = self.priorityButtons[index]
        UIView.animate(withDuration: 0.5) {
            button.backgroundColor = color
        }
        
        for index in filteredIndexes {
            let button = self.priorityButtons[index]
            UIView.animate(withDuration: 0.5) {
                button.backgroundColor = #colorLiteral(red: 0.703534755, green: 0.7368400091, blue: 0.7732545685, alpha: 1)
            }
        }
    }
    
    // MARK: -- Public function's
    public func addRequiredData(model: TasksDataManager) {
        self.model = model
    }
    
    // MARK: -- IBAction's
    @IBAction func lowButtonPressed(_ sender: UIButton) {
        self.setPriorityButtonBackgroundColor(atIndex: 0, color: Priority.low.color)
        self.selectedPriority = .low
    }
    
    @IBAction func mediumButtonPressed(_ sender: UIButton) {
        self.setPriorityButtonBackgroundColor(atIndex: 1, color: Priority.medium.color)
        self.selectedPriority = .medium
    }
    
    @IBAction func highButtonPressed(_ sender: UIButton) {
        self.setPriorityButtonBackgroundColor(atIndex: 2, color: Priority.high.color)
        self.selectedPriority = .high
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let task = Task(isDone: false,
                        name: self.taskName ?? "empty name",
                        priority: Int64(self.selectedPriority.rawValue))
        
        self.model.createTask(task)
        self.model.saveTasks()
        self.model.fetchTasks()
        self.dismiss(animated: true)
    }
    
    @IBAction func taskNameTextFieldEditingChanged(_ sender: UITextField) {
        self.check()
        self.taskName = sender.text
    }
}
