//
//  MainTableViewController.swift
//  
//
//  Created by Adam Reed on 2/16/18.
//

import UIKit

class MainTableViewController: UITableViewController, EditViewControllerDelegate {
    
    
    var lists = [TimerListItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "UpDownTimer"
        navigationItem.largeTitleDisplayMode = .always
        
        var newList = TimerListItem(name: "50mm Insert")
        
        var firstTimer = UpDownTimer()
        firstTimer.name = "WARM"
        firstTimer.coolDownTimer = 0
        firstTimer.heatUpTimer = 0
        newList.items.append(firstTimer)
        firstTimer = UpDownTimer()
        firstTimer.name = "COLD"
        newList.items.append(firstTimer)
        
        lists.append(newList)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- View Actions
    @IBAction func addListItem(_ sender: Any) {
        
        let newRowIndex = lists.count

        let newTimerObject = TimerListItem(name: "New Timer Object")
        var firstTimer = UpDownTimer()
        firstTimer.name = "New Timer"
        
        newTimerObject.items.append(firstTimer)
        lists.append(newTimerObject)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [ indexPath ]
        tableView.insertRows(at: indexPaths, with: .automatic)
   
    }
        
   
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTimers" {
            let controller = segue.destination as! timerTableViewController
            controller.timersObject = sender as! TimerListItem
        } else if segue.identifier == "Add" {
            let controller = segue.destination as! EditViewController
            controller.delegate = self
        }
    }
    

    // MARK:- Private Methods
    func makeCell(for tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell"
        if let cell =
            tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeCell(for: tableView)
        // Update cell informaiton
        let timerList = lists[indexPath.row]
        cell.textLabel?.text = timerList.name
        
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let timerlist = lists[indexPath.row]
        performSegue(withIdentifier: "ShowTimers", sender: timerlist)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let controller = storyboard!.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        controller.delegate =  self
        
        let timerListItem = lists[indexPath.row]
        controller.timerToEdit = timerListItem
        
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    // MARK: - Delegate methods
    func editViewControllerDidCancel(_ controller: EditViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func editViewController(_ controller: EditViewController, didFinishAdding timerListItem: TimerListItem) {
        let newRowIndex = lists.count
        let newTimer = UpDownTimer()
        timerListItem.items.append(newTimer)
        lists.append(timerListItem)
        
        let indexPath =  IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [ indexPath ]
        tableView.insertRows(at: indexPaths, with: .automatic)

        navigationController?.popViewController(animated: true)
    }
    
    func editViewController(_ controller: EditViewController, didFinishEditing timerListItem: TimerListItem) {
        
        if let index = lists.index(of: timerListItem) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = timerListItem.name
                
            }
        
        }
        
        navigationController?.popViewController(animated: true)
    }
        
        
}
    



