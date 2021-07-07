//
//  ViewController.swift
//  ToDoList
//
//  Created by Michał Nowak on 06/07/2021.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: -- Private variable's
    private var model: TasksDataManager!
    
    // MARK: -- IBOutlet's
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: -- Override function's
    override func loadView() {
        super.loadView()
        self.setup()
        
        self.model.fetchTasks()
    }
    
    override func viewDidLayoutSubviews() {
        self.addButton.layer.cornerRadius = self.addButton.frame.width / 2
        self.deleteButton.layer.cornerRadius = self.deleteButton.frame.width / 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddViewController" {
            if let vc = segue.destination as? AddViewController {
                vc.addRequiredData(model: self.model)
            }
        }
    }
    
    // MARK: -- IBAction's
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        if self.model.doneCount > 0 {
            self.showDeleteAlert()
        } else {
            self.showSelectionInfo()
        }
    }
    
    
    // MARK: -- Private function's
    private func setup() {
        self.setupModel()
        self.addButtonSetup()
        self.deleteButtonSetup()
        self.tableViewSetup()
    }
    
    private func setupModel() {
        self.model = TasksDataManager()
        self.model.delegate = self
    }
    
    private func addButtonSetup() {
        self.addButton.backgroundColor = #colorLiteral(red: 0.7128377083, green: 0.307490105, blue: 0.9686274529, alpha: 1)
        self.addButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func deleteButtonSetup() {
        self.deleteButton.backgroundColor = #colorLiteral(red: 0.7128377083, green: 0.307490105, blue: 0.9686274529, alpha: 1)
        self.deleteButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func tableViewSetup() {
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func showDeleteAlert() {
        let alert = UIAlertController(title: "Did you delete all completed task's?", message: "After this operation are lost irreversibly", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.model.removeAllDoneTasks()
            self.model.saveTasks()
            self.model.fetchTasks()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    private func showSelectionInfo() {
        let alert = UIAlertController(title: "No completed task's", message: "Check completed tasks that can be deleted", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            
        }))
        
        self.present(alert, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as? TaskTableViewCell else {
            fatalError("TaskTableViewCell identifier not found")
        }
        
        if let task = self.model.getTask(atIndex: indexPath.row) {
            let isChecked = task.isDone
            let taskName = task.name
            let priorityColor = Priority(rawValue: Int(task.priority))?.color
            
            cell.id = indexPath.row
            cell.isChecked = isChecked
            cell.taskName = taskName
            cell.priorityColor = priorityColor
            cell.delegate = self
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.view.frame.height * 0.08
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            self.model.deleteTask(atIndex: indexPath.row)
            self.model.saveTasks()
            self.model.fetchTasks()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension MainViewController: TaskTableViewCellDelegate {
    func didSelect(taskTableViewCell: TaskTableViewCell, didSelect: Bool) {
        guard let index = taskTableViewCell.id else {
            return
        }
        if let oldTask = self.model.getTask(atIndex: index) {
            let newTask = Task(isDone: true,
                               name: oldTask.name ,
                               priority: oldTask.priority)
            
            self.model.updateTask(task: newTask, atIndex: index)
            self.model.saveTasks()
        }
    }
    
    func didDeselect(taskTableViewCell: TaskTableViewCell, didDeselect: Bool) {
        guard let index = taskTableViewCell.id else {
            return
        }
        if let oldTask = self.model.getTask(atIndex: index) {
            let newTask = Task(isDone: false,
                               name: oldTask.name ,
                               priority: oldTask.priority)
            
            self.model.updateTask(task: newTask, atIndex: index)
            self.model.saveTasks()
        }
    }
}

extension MainViewController: TasksDataManagerDelegate {
    
    func fetchTasksSuccess(model: TasksDataManager, success: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
