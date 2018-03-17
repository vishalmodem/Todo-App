//
//  TableViewController.swift
//  Todo App
//
//  Created by Shanker Goud on 3/16/18.
//  Copyright © 2018 Shanker Goud. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
var array:[String] = ["First","Second","Third"]
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
        cell.textLabel?.text=array[indexPath.row]

    

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    @IBAction func addBtn(_ sender: UIBarButtonItem) {
        var tF = UITextField()
        let alertC = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let alertA = UIAlertAction(title: "Add Item", style: .default) { (action) in
          self.array.insert(tF.text!, at: 0)
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
