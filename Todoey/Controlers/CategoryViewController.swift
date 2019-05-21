//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Admir Sabanovic on 2019-05-21.
//  Copyright © 2019 Admir Sabanovic. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()

    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    

    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        
        return cell
        
        
    }
    
    //MARK: - Data Manipulation Methods
    
    func save (category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("ERROR saving context \(error)")
        }
        self.tableView.reloadData()
        
    }
    func loadCategories () {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }

    
    // MARK: - Tableview Delegate Methods
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    // MARK: - Add new Category


    @IBAction func BarButtonPressed(_ sender: UIBarButtonItem) {
        
            var textField = UITextField()
    
            let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
       
            let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
                let newCategory = Category()
                newCategory.name = textField.text!

                self.save(category: newCategory)
                
                 
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add new Category"
            
        }
        
        present(alert, animated: true, completion: nil)

        }

}

