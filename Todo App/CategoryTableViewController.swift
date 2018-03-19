//
//  CategoryTableViewController.swift
//  Todo App
//
//  Created by Shanker Goud on 3/17/18.
//  Copyright © 2018 Shanker Goud. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var array = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }

    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var tb = UITextField()
        let aCtrl = UIAlertController(title: "Add Text", message: "", preferredStyle: .alert)
        let aa1 = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let c = Category(context: self.context)
            c.name = tb.text
            self.array.append(c)
            self.saveData()
        }
        let aa2 = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (c) in
            
        }
        aCtrl.addAction(aa1)
        aCtrl.addAction(aa2)
        aCtrl.addTextField { (tf) in
            tf.placeholder = "Enter Item"
            tb = tf;
        }
        present(aCtrl, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
                cell.textLabel?.text = array[indexPath.row].name
        

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SEG", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        let destination = segue.destination as! TableViewController
        if let ip = tableView.indexPathForSelectedRow {
            destination.categoryParent = array[ip.row]
        }
    }
    
    func saveData() {
        do{
      try context.save()
        } catch{
            print(error)
        }
        tableView.reloadData()
    }
    func loadData(req: NSFetchRequest<Category> = Category.fetchRequest())  {
        
        do{
            array = try context.fetch(req)
        }
        catch{
            print(error)
        }
        tableView.reloadData()
    }

}
extension CategoryTableViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.predicate = NSPredicate(format: "name CONTAINS[cb] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        loadData(req:request)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadData()
            DispatchQueue.main.async(execute: {
                searchBar.resignFirstResponder()
            })
        }
    }
}
