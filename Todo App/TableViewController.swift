//
//  TableViewController.swift
//  Todo App
//
//  Created by Shanker Goud on 3/16/18.
//  Copyright © 2018 Shanker Goud. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    var categoryParent:Category?{
        didSet{
            loadData()
        }
    }
    var array =  [TodoClass]()
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
    }



    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTodo", for: indexPath)
        let item = array[indexPath.row]
        cell.textLabel?.text=item.title
        cell.accessoryType=item.done == true ? .checkmark : .none
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        array[indexPath.row].done = !array[indexPath.row].done
        //context.delete(array[indexPath.row])
       // array.remove(at: indexPath.row)
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    @IBAction func addBtn(_ sender: UIBarButtonItem) {
        var tF = UITextField()
        let alertC = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let alertA = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem =  TodoClass(context: self.context)
            newItem.title = tF.text!
            newItem.done=false
            newItem.child=self.categoryParent
          self.array.append(newItem)
          self.saveData()
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
    
    func  saveData(){
        do{
           try context.save()
        } catch{
            print(error)
        }
        tableView.reloadData()
    }
    func loadData(using request : NSFetchRequest<TodoClass> = TodoClass.fetchRequest(), predicate : NSPredicate? = nil){
        let secondPredicate = NSPredicate(format: "child.name MATCHES %@", categoryParent!.name!)
        if let aP  = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [secondPredicate,aP])
        } else{
            request.predicate = secondPredicate
        }
        
            do{
                array = try context.fetch(request)
            } catch{
                print(error)
            }
        tableView.reloadData()
        }
    }
extension TableViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<TodoClass> = TodoClass.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cb] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadData(using: request, predicate: predicate)
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
