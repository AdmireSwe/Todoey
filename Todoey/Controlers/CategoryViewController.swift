//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Admir Sabanovic on 2019-05-21.
//  Copyright © 2019 Admir Sabanovic. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {

    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    

    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
        
        
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCategory () {
        do {
            try context.save()
        } catch {
            print("ERROR saving context \(error)")
        }
        self.tableView.reloadData()
        
    }
    func loadCategories () {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error Loading Data \(error)")
        }
        
        tableView.reloadData()
    }

    
    // MARK: - Tableview Delegate Methods
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    // MARK: - Add new Category


    @IBAction func BarButtonPressed(_ sender: UIBarButtonItem) {
        
            var textField = UITextField()
    
            let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
       
            let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
                
                self.categories.append(newCategory)
                
                self.saveCategory()
                
                 
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add new Category"
            
        }
        
        present(alert, animated: true, completion: nil)

        }

}
