//
//  ViewController.swift
//  MyList
//
//  Created by cmr on 18/9/30.
//  Copyright © 2018年 cmr. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    var enterText : String?

    var list = ["apple","banana","pie"]
    
    var selectedData : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.title = "MyListofDay"
        tableView.delegate = self
        tableView.dataSource = self
        
        var list = defaults.array(forKey: "todolist") as! [String]
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            
        cell?.textLabel?.text = list[indexPath.row]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedData = list[indexPath.row]
        
        performSegue(withIdentifier: "goToD", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToD" {
            
            let destinationVC = segue.destination as! ItemViewController
            destinationVC.dataPassed = selectedData
            
        }
    }

    @IBAction func addClicked(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add item", message: "Add items in the list,do remember", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Try to add items in the list"
            
            textField = alertTextField
           
            
        }
        
        let action =  UIAlertAction(title: "Add", style: .default) { (action) in
        // What will happened when the user click the add button!
            
            self.list.append(textField.text!)
            
            self.defaults.setValue(self.list, forKey: "todolist")
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

