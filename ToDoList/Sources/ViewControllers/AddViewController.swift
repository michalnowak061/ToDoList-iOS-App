//
//  AddViewController.swift
//  ToDoList
//
//  Created by Michał Nowak on 06/07/2021.
//

import UIKit

class AddViewController: UIViewController {
    // MARK: -- IBOutlet's
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet var priorityButtons: [UIButton]!
    
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: -- Override function's
    override func loadView() {
        super.loadView()
        self.setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: -- Private function's
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
    
    // MARK: -- IBAction's
    @IBAction func lowButtonPressed(_ sender: UIButton) {
        self.setPriorityButtonBackgroundColor(atIndex: 0, color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
    }
    
    @IBAction func mediumButtonPressed(_ sender: UIButton) {
        self.setPriorityButtonBackgroundColor(atIndex: 1, color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    }
    
    @IBAction func highButtonPressed(_ sender: UIButton) {
        self.setPriorityButtonBackgroundColor(atIndex: 2, color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
