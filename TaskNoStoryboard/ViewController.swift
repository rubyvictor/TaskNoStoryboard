//
//  ViewController.swift
//  exerciseNoStoryBoard
//
//  Created by Victor Lee on 16/12/16.
//  Copyright © 2016 VictorLee. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let cellId = "cellId"
    
    var tasks: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "TODo list without storybaord"
        tableView.register(TaskCell.self, forCellReuseIdentifier: cellId)
        self.tasks.append("practice algo and data structure")
        self.tasks.append("go for interview")
        self.tasks.append("do interview assignment and test")
        self.tasks.append("ace interview and get job")
        
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(handleAdd))
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    func handleAdd() {
        
        let alertController = UIAlertController(title: "Add New Task", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let saveAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler:
            { (action) -> Void in
                let taskNameTextField = (alertController.textFields?[0])! as UITextField
                self.tasks.append(taskNameTextField.text!)
                self.tableView.reloadData()
                
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default)
        { (action) -> Void in
            
        }
        
        alertController.addTextField { (textField: UITextField) in
            textField.placeholder = "Task Name"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TaskCell
        
        cell.taskLabel.text = self.tasks[indexPath.item]
        cell.backgroundColor = UIColor.orange
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tasks.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Confirm delete"
    }
    
    class TaskCell:  UITableViewCell {
        
        let taskLabel: UILabel = {
            let label = UILabel()
            label.text = "My Task"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
            
        }()
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }
        
        func setupViews() {
            addSubview(taskLabel)
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-52-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": taskLabel]))
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": taskLabel]))
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    
}
