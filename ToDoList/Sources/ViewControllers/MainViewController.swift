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
        self.addButtonSetup()
    }
    
    private func addButtonSetup() {
        self.addButton.backgroundColor = #colorLiteral(red: 0.7128377083, green: 0.307490105, blue: 0.9686274529, alpha: 1)
        self.addButton.titleLabel?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addButton.layer.cornerRadius = self.addButton.frame.width / 2
    }
}

