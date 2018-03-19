//
//  TableViewController.swift
//  Todo App
//
//  Created by Shanker Goud on 3/16/18.
//  Copyright © 2018 Shanker Goud. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class TableViewController: UITableViewController {
    var categoryParent:Category?{
        didSet{
            loadData()
        }
    }
    var array: Results<TodoClass>?
    let realm = try! Realm()
//let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
    }



    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTodo", for: indexPath)
        let item = array?[indexPath.row]
        cell.textLabel?.text=item!.title
        cell.accessoryType=item!.done == true ? .checkmark : .none
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = array?[indexPath.row]{
            do{
                try! realm.write {
                    item.done = !item.done
                }
            } catch{
                print(error)
            }
        }
        tableView.reloadData()
        
        //array?[indexPath.row].done = !(array?[indexPath.row].done)!
        //context.delete(array[indexPath.row])
       // array.remove(at: indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    @IBAction func addBtn(_ sender: UIBarButtonItem) {
        var tF = UITextField()
        let alertC = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let alertA = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
           // let newItem =  TodoClass(context: self.context)
            if let selectedCategory = self.categoryParent{
            do{
                try self.realm.write {
                    let newItem =  TodoClass()
                    newItem.title = tF.text!
                    newItem.dateCreated = Date()
                    selectedCategory.items.append(newItem)
                }
            } catch{
                print(error)
                }
        }
            self.tableView.reloadData()
        }
        let alertB = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Cancelled")
        }
        alertC.addTextField { (textField) in
            textField.placeholder = "Add Item"
            tF = textField
        }
        alertC.addAction(alertA)
        alertC.addAction(alertB)

        present(alertC, animated: true, completion: nil)
    }
    
//    func  saveData(item : TodoClass){
//        do{
//           try context.save()
//        } catch{
//            print(error)
//        }
//        tableView.reloadData()
//    }
//
    
    //func loadData(using request : NSFetchRequest<TodoClass> = TodoClass.fetchRequest(), predicate : NSPredicate? = nil){
//        let secondPredicate = NSPredicate(format: "child.name MATCHES %@", categoryParent!.name!)
//        if let aP  = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [secondPredicate,aP])
//        } else{
//            request.predicate = secondPredicate
//        }
//
//            do{
//                array = try context.fetch(request)
//            } catch{
//                print(error)
//            }
//        tableView.reloadData()
//        }
//    }
    
    func loadData() {
        array=categoryParent?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}
extension TableViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<TodoClass> = TodoClass.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cb] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        loadData(using: request, predicate: predicate)
        array = array?.filter("title CONTAINS[cd] %@",searchBar.text! ).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text?.count == 0){
            loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}
