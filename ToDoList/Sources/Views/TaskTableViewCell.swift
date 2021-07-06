//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Michał Nowak on 06/07/2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    // MARK: -- IBOutlet's
    @IBOutlet weak var checkbox: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var priority: UIView!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
