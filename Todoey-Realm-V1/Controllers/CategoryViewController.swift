//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Abdelrahman Zain on 23/02/2025.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
//    var categoryArray = [Category]()
    var categories: Results<Category>?

    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        do{
//            realm = try Realm()
//        } catch {
//            print("Error in Realm : \(error)")
//        }
        tableView.separatorStyle = .none
        loadCategories()
    }
//    
//    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
//        var textField = UITextField()
//        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
//        let action = UIAlertAction(title: "Add Category", style: .default) { alert in
//            let newCategory = Category()
//            newCategory.title = textField.text!
//            self.categoryArray.append(newCategory)
//            self.save(category: newCategory)
//        }
//        alert.addTextField { alertTextField in
//            alertTextField.placeholder = "Enter new category"
//            textField = alertTextField
//        }
//        alert.addAction(action)
//        present(alert, animated: true)
//
//    }
//    
//    
//    // MARK: - Table view data source
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return categoryArray.count
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
//        let category = categoryArray[indexPath.row]
//        cell.textLabel?.text = category.title
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //performSegue(withIdentifier: "goToListView", sender: self)
//    }
//    
////    func loadCategories () {
////        let request : NSFetchRequest<Category> = Category.fetchRequest()
////        do {
////            categoryArray = try context.fetch(request)
////            tableView.reloadData()
////        } catch {
////            print("Failed to fetch items: \(error.localizedDescription)")
////        }    }
////    
//    
//    func save(category : Category){
//        
//        do {
//            try realm.write {
//                realm.add(category)
//            }
//            tableView.reloadData()
//        }catch {
//            print(error)
//        }
//    }
// // MARK: - Navigation
// 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     let destinationVC = segue.destination as! ToDoListViewController
//     if let indexPath = tableView.indexPathForSelectedRow {
//         destinationVC.selectedCategory = categoryArray[indexPath.row]
//     }
//     
// // Get the new view controller using segue.destination.
// // Pass the selected object to the new view controller.
// }
//
//}
//
//
////UISearchBarDelegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].title ?? "No Categories added yet"
        let color = UIColor(hexString: categories?[indexPath.row].color ?? "#FFFFFF")
        cell.backgroundColor = color
        cell.textLabel?.textColor = ContrastColorOf(color!, returnFlat: true)
        return cell
    }
    
    
    //Mark: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //Mark: - Delete Data from Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    //Mark: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
//    }
//    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a New Cateogry", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.title = textField.text!
            let colorString = UIColor .randomFlat().hexValue()
            newCategory.color = colorString
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        present(alert, animated: true, completion: nil)
    }
    
    //Mark: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    
}
