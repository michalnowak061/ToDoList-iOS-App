//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Michał Nowak on 06/07/2021.
//

import UIKit
import MBCheckboxButton

class TaskTableViewCell: UITableViewCell {
    // MARK: -- Private variable's
    private var priorityDot: UIView = UIView()
    
    // MARK: -- Public variable's
    public var id: Int?
    
    public weak var delegate: TaskTableViewCellDelegate?
    
    public var isChecked: Bool? {
        get {
            return self.checkbox.isSelected
        }
        set {
            return self.checkbox.isSelected = newValue ?? false
        }
    }
    
    public var taskName: String? {
        get {
            return self.label.text
        }
        set {
            self.label.text = newValue
        }
    }
    
    public var priorityColor: UIColor? {
        get {
            return self.priorityDot.backgroundColor
        }
        set {
            self.priorityDot.backgroundColor = newValue
        }
    }
    
    // MARK: -- IBOutlet's
    @IBOutlet weak var checkbox: CheckboxButton!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var priority: UIView!
    
    // MARK: -- Override function's
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setup()
    }
    
    // MARK: -- Private function's
    private func setup() {
        self.setupCheckbox()
        self.setupLabel()
        self.setupPriorityView()
    }
    
    private func setupCheckbox() {
        self.checkbox.style = .circle
        self.checkbox.checkboxLine = CheckboxLineStyle(checkBoxHeight: self.frame.height * 0.5)
        self.checkbox.checkBoxColor = CheckBoxColor(activeColor: #colorLiteral(red: 0.7128377083, green: 0.307490105, blue: 0.9686274529, alpha: 1), inactiveColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), inactiveBorderColor: #colorLiteral(red: 0.7128377083, green: 0.307490105, blue: 0.9686274529, alpha: 1), checkMarkColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        self.checkbox.delegate = self
    }
    
    private func setupLabel() {
        self.label.adjustsFontSizeToFitWidth = true
        self.label.numberOfLines = 0
    }
    
    private func setupPriorityView() {
        self.priorityDot.translatesAutoresizingMaskIntoConstraints = false
        let dotSize = self.frame.height * 0.2
        self.priorityDot.layer.cornerRadius = dotSize / 2
        
        self.priority.addSubview(self.priorityDot)
        
        // constraints
        let constraints = [
            self.priorityDot.centerXAnchor.constraint(equalTo: self.priority.centerXAnchor),
            self.priorityDot.centerYAnchor.constraint(equalTo: self.priority.centerYAnchor),
            self.priorityDot.widthAnchor.constraint(equalToConstant: dotSize),
            self.priorityDot.heightAnchor.constraint(equalToConstant: dotSize)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension TaskTableViewCell: CheckboxButtonDelegate {
    func chechboxButtonDidSelect(_ button: CheckboxButton) {
        if let text = self.label.text {
            self.label.attributedText = String.makeSlashText(text)
            
            UIView.animate(withDuration: 0.5) {
                self.label.alpha = 0.5
                self.priority.alpha = 0.5
            }
            
            self.delegate?.didSelect(taskTableViewCell: self, didSelect: true)
        }
    }
    
    func chechboxButtonDidDeselect(_ button: CheckboxButton) {
        if let text = self.label.text {
            self.label.attributedText = NSMutableAttributedString(string: text)
            
            UIView.animate(withDuration: 0.5) {
                self.label.alpha = 1.0
                self.priority.alpha = 1.0
            }
            
            self.delegate?.didDeselect(taskTableViewCell: self, didDeselect: true)
        }
    }
}
