//
//  FilterTableViewController.swift
//  ChurchFinder
//
//  Created by Sarah Burgess on 2/9/16.
//  Copyright © 2016 Michael Curtis. All rights reserved.
//

import UIKit

protocol filterResultsDelegate{
    func done(child: FilterTableViewController)
}


class FilterTableViewController: UITableViewController {

    @IBOutlet weak var tabbar: UITabBar!
    let labels = ["Denomination", "Worship Style", "Size", "Times"]
    let denoms = ["Evangelical", "Lutheran", "Catholic", "Protestant", "Boatright"]
    let worshipStyles = ["Contemporary", "Traditional", "80's Disco"]
    let sizes = ["0-100", "100-200", "200-300", "300+"]
    let times = ["10:00-11:00","11:00-12:00", "Anytime before kickoff"]
    var delegate: filterResultsDelegate!
    var check: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    //delegate.done(self)

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> FilterViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tblCell", forIndexPath: indexPath) as! FilterViewCell
        cell.textLabel?.text = labels[indexPath.row]
        switch (indexPath.row){
            case 0:
                cell.pickerLabels = denoms
                break
            case 1:
                cell.pickerLabels = worshipStyles
                break
            case 2:
                cell.pickerLabels = sizes
                break
            case 3:
                cell.pickerLabels = times
                break
            default: break
        }
        if(indexPath.row == 0){
            
            
        }
        cell.setSelected(true, animated: true)
        // Configure the cell...
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}