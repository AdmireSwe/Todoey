//
//  ViewController.swift
//  Todoey
//
//  Created by Admir Sabanovic on 2019-05-19.
//  Copyright © 2019 Admir Sabanovic. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item] ()
    
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
        
    }
 // MARK - TableView Datasource Methods
    
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
    
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
        
    }

// MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveData()
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK - Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField ()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what happens when user presses add item
            
            let newItem = Item ()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveData()
            
        self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
     
        present (alert, animated: true, completion: nil)
    }

// MARK - Model Manipulation Method

func saveData () {
    
    let encoder = PropertyListEncoder ()
    
    do {
        
        let data = try encoder.encode(itemArray)
        try data.write(to: dataFilePath!)
    } catch {
        print("ERROR Encodin item array \(error)")
    }
    
    }
    
    func loadItems () {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder ()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("error loading data \(error)")
            }
        }
    }
}
