/*
 Copyright 2016 Serious Llama and Grove City College. All rights reserved.
 
 Author: Charlie Mathews
 Created: 4/10/16
 */


import Foundation
import UIKit

class FiltersViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    //var filterLabels : [String] = ["Denomination", "Worship Style", "Size"]
    var filterTypes = data.filterTypes
    var filterData = data.filterData
    
    //currently selected values
    var filterSelected : Dictionary<String, AnyObject> = data.currentParameters    // currently selected values
    var filterTimes : [Int] = [0, 0]                            // currently selected times
    
    //toggle option
    var filterByServiceTime : Bool = false
    
    var current_row = 0
    var current_section = 0
    
    @IBAction func clearFilters(sender: AnyObject) {
        //viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        print(filterSelected)
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?{
        
        current_row = indexPath.row
        current_section = indexPath.section
        
        return indexPath
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        table.deselectRowAtIndexPath(indexPath, animated: true)
        
        if(current_section == 0) {
            
            self.performSegueWithIdentifier("listFilterSegue", sender: self)
            
        } else if(current_section == 1) {
            
            var t : String = ""
            var m : String = ""
            
            if(current_row == 1) {
                t = "Start"
                m = "start 'er up bitches"
                
                self.performSegueWithIdentifier("timeFilterSegue", sender: self)
                
            } else if(current_row == 2) {
                t = "End"
                m = "shut it down, butter bitches"
                
                self.performSegueWithIdentifier("timeFilterSegue", sender: self)
            }
        
            
            
        } else {
            
            
            
        }
        
        /*
         selectedFilterRow = indexPath.row
         let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! FilterViewCell
         selectedFilter = currentCell.cellName
         self.performSegueWithIdentifier("specificFilterSegue", sender: self)
         */
    }
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let dest = segue.destinationViewController
        
        if(segue.identifier == "genericFilterSegue") {
            
            //not setup
            
        } else if(segue.identifier == "listFilterSegue") {
            
            let landing = dest as! FilterByListController
            let enumeration = filterData[Array(filterTypes.keys)[current_row]]
            
            landing.enumeration = enumeration as! [String]
            landing.name = Array(filterTypes.values)[current_row]
            
            
        } else if(segue.identifier == "timeFilterSegue") {
            
            // setup destination
            //if section is 1 and row is 1/2
            
        }
        
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(section == 0) { // denomination, worship style, size
            return filterData.count
        } else if (section == 1) {
            
            if(filterByServiceTime == true) {
                return 3 // time question, as early as, as late as
            } else {
                if(data.filterByTime == false) {
                    return 1
                } else {
                    return 3
                }
            }
            
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Search Criteria"
        } else if section == 1 {
            return "Service Times"
        } else {
            return "undefined"
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0) {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("filterCell", forIndexPath: indexPath) as! FilterViewCell
            
            let name = Array(filterTypes.values)[indexPath.row]
            let column_name = Array(filterTypes.keys)[indexPath.row]
            
            var value : String
            if let v = filterSelected[column_name] as? String {
                value = v
            } else {
                value = "Any"
            }
        
            cell.filter_name.text = name
            cell.filter_value.text = value
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let enabled : Bool = data.filterByTime
            
            /*
            if let times = filterSelected["times"] as? Dictionary<String, AnyObject> {
                if let e = times["enabled"] as? Bool {
                    //enabled = e
                }
            }
             */
            
            if(indexPath.row == 0) {
                let cell = tableView.dequeueReusableCellWithIdentifier("timesToggleCell", forIndexPath: indexPath) as! FilterTimesToggleCell
                
                cell.toggle.on = enabled
                
                return cell
            } else if(indexPath.row == 1) {
                let cell = tableView.dequeueReusableCellWithIdentifier("filterCell", forIndexPath: indexPath) as! FilterViewCell
                
                cell.filter_name.text = "from"
                cell.filter_value.text = "00:00"
                
                return cell
            } else if(indexPath.row == 2) {
                let cell = tableView.dequeueReusableCellWithIdentifier("filterCell", forIndexPath: indexPath) as! FilterViewCell
                
                cell.filter_name.text = "to"
                cell.filter_value.text = "00:00"
                
                return cell
            } else {
                return tableView.dequeueReusableCellWithIdentifier("filterCell", forIndexPath: indexPath)
            }
            
        } else {
            return tableView.dequeueReusableCellWithIdentifier("filterCell", forIndexPath: indexPath)
        }
    }
    
    @IBAction func doneWithList(segue: UIStoryboardSegue) {
        let sender = segue.sourceViewController as! FilterByListController
        
        let key = Array(filterTypes.keys)[current_row]
        let newValue = sender.selection
        
        updateSelected(key, v: newValue)
    }
    
    func updateSelected(k : String, v : String) {
        print("Filters will update \(k) with value \(v)")
        filterSelected[k] = v
        table.reloadData()
    }
    
    @IBAction func clearAll(sender: AnyObject) {
        
        for (k,_) in filterTypes {
            if filterSelected[k] != nil {
                self.filterSelected[k] = "Any"
            }
        }
        
        print("Resetting filters to default.")
        table.reloadData()
    }

    @IBAction func toggleFlipped(sender: AnyObject) {
        
        data.filterByTime = !data.filterByTime
        table.reloadData()
        
    }
    
}
