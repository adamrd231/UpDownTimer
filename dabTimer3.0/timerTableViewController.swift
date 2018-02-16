//
//  timerTableViewController.swift
//  dabTimer3.0
//
//  Created by Adam Reed on 2/12/18.
//  Copyright © 2018 RD concepts. All rights reserved.
//

import UIKit

class timerTableViewController: UITableViewController, UpDownTimerViewControllerDelegate {
    
    var timersList = [UpDownTimer]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Up Down Timer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        var firstTimer = UpDownTimer()
        firstTimer.name = "1st Nail"
        
        timersList.append(firstTimer)
        
        firstTimer = UpDownTimer()
        firstTimer.name = "2nd Nail"
        firstTimer.heatUpTimer = 60
        
        timersList.append(firstTimer)
        
    }

    @IBAction func addTimer(_ sender: Any) {
        
        let newRowIndex = timersList.count
        
        let newTimer = UpDownTimer()
        newTimer.name = "New Timer"
        timersList.append(newTimer)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
    }
    
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTimer" {
            let controller = segue.destination as! UpDownTimerViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.timerToWorkWith = timersList[indexPath.row]
            }
        }
    }

  
    //MARK:- Private Methods
    func makeCell(for tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "TimerItem"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: UpDownTimer) {
        
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.name
        let upTime = cell.viewWithTag(1001) as! UILabel
        upTime.text = String(item.heatUpTimer)
        let downTime = cell.viewWithTag(1002) as! UILabel
        downTime.text = String(item.coolDownTimer)
        
    }
    
    
    //MARK:- Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timersList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = makeCell(for: tableView)
            let listTimer = timersList[indexPath.row]
            configureText(for: cell, with: listTimer)
            cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let listTimer = timersList[indexPath.row]
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        timersList.remove(at: indexPath.row)

        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    
    
    //MARK:- AddTimerTableViewController Delegates
    
    func addTimerTableViewControllerDidCancel(_ controller: AddTimerTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addTimerTableViewController(_ controller: AddTimerTableViewController, didFinishAdding timer: UpDownTimer) {
        
        let newRowIndex = timersList.count
        timersList.append(timer)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [ indexPath ]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func returnTimerToWorkWith(_ controller: UpDownTimerViewController, didFinishWithTimer timer: UpDownTimer) {
        if let index = timersList.index(of: timer) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: timer)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
}
    
    

