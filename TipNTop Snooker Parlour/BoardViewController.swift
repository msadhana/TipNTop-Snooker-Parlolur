//
//  BoardViewController.swift
//  TipNTop Snooker Parlour
//
//  Created by Dineshkumar on 11/05/15.
//  Copyright (c) 2015 TipNTop Cue Sports. All rights reserved.
//


import UIKit
public class tableUsage {
    
    class var sharedInstance: tableUsage {
        
        struct Static {
            static let instance: tableUsage = tableUsage()
        }
        return Static.instance
    }
    public  var usage = ["Free", "Free" , "Free" , "Free"]
    
}
class BoardViewController: UITableViewController {
    var tableOp = ["Board1", "Board2", "Board3", "Board4"]
    
    var segueIdentifer = ["Board1Segue"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableOp.count ;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("mycustom1", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = tableOp[indexPath.row]
        cell.detailTextLabel?.text = tableUsage.sharedInstance.usage[indexPath.row]
        cell.imageView?.image = UIImage(named: "Timer")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        self.tableView!.beginUpdates()
        //tableUsage.sharedInstance.usage[indexPath.row] = "Playing"
        self.tableView!.reloadData()
        self.tableView!.endUpdates()
        
        self.performSegueWithIdentifier(segueIdentifer[indexPath.row], sender: self)
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
    
    // Configure the cell...
    
    return cell
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
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
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    */
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
    }
    
    
}
