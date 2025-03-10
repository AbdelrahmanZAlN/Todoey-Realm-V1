//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: SwipeTableViewController  {
    
    //    var itemArray = [Item]()
    var toDoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    
    //    let defaults = UserDefaults.standard
    //    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //
    //    //MARK: - UITableViewDataSource
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return itemArray.count
    //    }
    //
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    //        let item = itemArray[indexPath.row]
    //        cell.textLabel?.text = item.title
    //
    //        cell.accessoryType = item.isDone ? .checkmark : .none
    //        return cell
    //    }
    //
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        let item = itemArray[indexPath.row]
    //        item.isDone = !item.isDone
    //
    //        saveItems()
    //        tableView.deselectRow(at: indexPath, animated: true)
    //
    //    }
    //
    //    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
    //        var textField = UITextField()
    //        let alert = UIAlertController(title: "Add New TodoeyItem", message: "", preferredStyle: .alert)
    //
    //        let action = UIAlertAction(title: "Add Item", style: .default) { alert in
    //            let newItem = Item()
    //            newItem.title = textField.text!
    //            newItem.isDone = false
    //            self.itemArray.append(newItem)
    //            self.saveItems()
    //        }
    //
    //        alert.addTextField { alertTextField in
    //            alertTextField.placeholder = "Enter new item"
    //            textField = alertTextField
    //
    //        }
    //
    //        alert.addAction(action)
    //
    //        present(alert, animated: true, completion: nil)
    //    }
    //    func saveItems () {
    //
    ////        do {
    ////            try context.save()
    ////            tableView.reloadData()
    ////        }catch {
    ////            print(error)
    ////        }
    //    }
    ////    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
    ////
    ////        let mainPredicate = NSPredicate(format: "parentCategory.title MATCHES %@", selectedCategory!.title!)
    ////        if let additionalPredicate = predicate {
    ////            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [mainPredicate, additionalPredicate])
    ////        }
    ////        else {
    ////            request.predicate = mainPredicate
    ////        }
    ////        do {
    ////            itemArray = try context.fetch(request)
    ////            tableView.reloadData()
    ////        } catch {
    ////            print("Failed to fetch items: \(error.localizedDescription)")
    ////        }
    ////    }
    ////
    //}
    //
    //// MARK: -UISearchBarDelegate
    //
    //extension ToDoListViewController : UISearchBarDelegate {
    //
    ////    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    ////        let request : NSFetchRequest<Item> = Item.fetchRequest()
    ////        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
    ////        request.sortDescriptors = [ NSSortDescriptor(key: "title", ascending: true)]
    ////        loadItems(with: request,predicate: predicate)
    ////    }
    ////    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    ////        if(searchBar.text?.count == 0) {
    ////            DispatchQueue.main.async {
    ////                searchBar.resignFirstResponder()
    ////            }
    ////            loadItems()
    ////        }
    ////    }
    ////    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    ////        searchBar.text = ""
    ////        DispatchQueue.main.async {
    ////            searchBar.resignFirstResponder()
    ////        }
    ////        loadItems()
    ////    }
    //}
    
    //Mark - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.isDone ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    //Mark - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write{
                    // realm.delete(item)
                    item.isDone = !item.isDone
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
//        
//        var textField = UITextField()
//        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
//        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//            if let currentCategory = self.selectedCategory {
//                do {
//                    try self.realm.write {
//                        let newItem = Item()
//                        newItem.title = textField.text!
//                        newItem.dateCreated = Date()
//                        currentCategory.items.append(newItem)
//                    }
//                } catch {
//                    print("Error saving new items, \(error)")
//                }
//            }
//            self.tableView.reloadData()
//        }
//        alert.addTextField { (alertTextField) in
//            alertTextField.placeholder = "Create new item"
//            textField = alertTextField
//        }
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
//    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
                var textField = UITextField()
                let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                    if let currentCategory = self.selectedCategory {
                        do {
                            try self.realm.write {
                                let newItem = Item()
                                newItem.title = textField.text!
                                newItem.dateCreated = Date()
                                currentCategory.items.append(newItem)
                            }
                        } catch {
                            print("Error saving new items, \(error)")
                        }
                    }
                    self.tableView.reloadData()
                }
                alert.addTextField { (alertTextField) in
                    alertTextField.placeholder = "Create new item"
                    textField = alertTextField
                }
                alert.addAction(action)
                present(alert, animated: true, completion: nil)

    }
    //Mark - Model Manipulation Methods
    func loadItems() {
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write{
                    realm.delete(item)
                }
            } catch {
                print("Error deleting item, \(error)")
            }
        }
    }
}


//Mark: - Searchbar delegate methods
extension ToDoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    
    
}
