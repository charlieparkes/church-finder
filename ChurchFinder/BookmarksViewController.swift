//
//  BookmarksViewController.swift
//  ChurchFinder
//
//  Created by Daniel Mitchell on 2/29/16.
//  Copyright © 2016 Michael Curtis. All rights reserved.
//

import UIKit

class BookmarksViewController: UITableViewController, detailedViewDelegate {
    
    let churchCellIdentifier = "ChurchListCell"
    var current = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }

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
        return Data.sharedInstance.bookmarks.count
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        current = indexPath.row
        return indexPath
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(churchCellIdentifier, forIndexPath: indexPath) as! ChurchListCell
        
        // Configure the cell...
        cell.setCellInfoBookmark(indexPath)
        return cell
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            Data.sharedInstance.removeBookmark(indexPath.row)
            
            tableView.reloadData()
        }
    }
    //MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "detailedChurchSegueBook") {
            
            let dest = segue.destinationViewController as! DetailedViewController
            
            dest.church = Data.sharedInstance.bookmarks[current]
        }
    }
    
    func done(vc: DetailedViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel(segue :UIStoryboardSegue) {
        NSLog("Got rid of him.")
    }
}
