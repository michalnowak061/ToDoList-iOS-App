//
//  ViewController.swift
//  ToDoList
//
//  Created by Michał Nowak on 06/07/2021.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: -- IBOutlet's
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: -- Override function's
    override func loadView() {
        super.loadView()
        self.setup()
    }

    // MARK: -- Private function's
    private func setup() {
        self.addButtonSetup()
        self.tableViewSetup()
    }
    
    private func addButtonSetup() {
        self.addButton.backgroundColor = #colorLiteral(red: 0.7128377083, green: 0.307490105, blue: 0.9686274529, alpha: 1)
        self.addButton.titleLabel?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addButton.layer.cornerRadius = self.addButton.frame.width / 2
        self.addButton.transform = CGAffineTransform.init(scaleX: 0.6, y: 0.6)
    }
    
    private func tableViewSetup() {
        self.tableView.allowsSelection = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as? TaskTableViewCell else {
            fatalError("TaskTableViewCell identifier not found")
        }
        
        cell.id = indexPath.row
        cell.isChecked = false
        cell.taskName = "Task name" + String(indexPath.row)
        cell.priorityColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.view.frame.height * 0.08
    }
}

extension MainViewController: TaskTableViewCellDelegate {
    func didSelect(taskTableViewCell: TaskTableViewCell, didSelect: Bool) {
        print("didSelect: \(String(describing: taskTableViewCell.id))")
    }
    
    func didDeselect(taskTableViewCell: TaskTableViewCell, didDeselect: Bool) {
        print("didDeselect: \(String(describing: taskTableViewCell.id))")
    }
}
