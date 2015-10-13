//
//  canteenDetailViewController.swift
//  TipNTop Snooker Parlour
//
//  Created by Dineshkumar on 03/09/15.
//  Copyright (c) 2015 TipNTop Cue Sports. All rights reserved.
//

import Foundation
import CoreData

class additemCell: UITableViewCell {
    
    @IBOutlet weak var item: UITextField!
    
    @IBOutlet weak var quantity: UITextField!
    
    @IBOutlet weak var price: UITextField!
    
    @IBAction func addAction(sender: AnyObject) {
        
        println("button pressed")
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext! as NSManagedObjectContext
        
        let newitem = NSEntityDescription.insertNewObjectForEntityForName("Canteen", inManagedObjectContext: managedContext) as! Canteen
        
        newitem.setValue(item.text, forKey: "item")
      
        managedContext.save(nil)
        
        // sender.self.tableView.reloadData()
        
    }
}


class canteenDetailViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
   // @IBOutlet var tableView: UITableView!
    @IBOutlet var tableView: UITableView!
    
    
    
    @IBOutlet weak var itemName: UITextField!
    
    @IBOutlet weak var quant: UITextField!
    
    @IBOutlet weak var price: UITextField!
    
    var canteen = [Canteen]()

    var totalq = Int16(0)
    var totalp = Float(0.0)
    
    @IBAction func addNewItem(sender: AnyObject) {
        
        println("button pressed")
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext! as NSManagedObjectContext
        
        let newitem = NSEntityDescription.insertNewObjectForEntityForName("Canteen", inManagedObjectContext: managedContext) as! Canteen
        
        newitem.setValue(itemName.text, forKey: "item")
        var quantityF = NSNumber(integer:(quant.text as NSString).integerValue)
        var priceF = NSNumber(float: (price.text as NSString).floatValue)
        var totalPriceF = NSNumber(float: ((quant.text as NSString).floatValue * (price.text as NSString).floatValue))
        
        newitem.setValue(quantityF, forKey: "quantity")
        newitem.setValue(priceF, forKey: "price")
        newitem.setValue(totalPriceF, forKey: "totalprice")
        
        //var code =
        newitem.setValue("C\(BoardManager.sharedInstance.pdcode)", forKey: "code")
        
        
        managedContext.save(nil)
        
        BoardManager.sharedInstance.pdcode++
        
        println(newitem)
        
        let fetchRequest = NSFetchRequest(entityName:"Canteen")
        var error: NSError?
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [Canteen]?
        
        
        if let results = fetchedResults {
            canteen = results
            println("loading")
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        totalq = 0
        totalp = 0.0
        
        self.tableView.reloadData()
        
    }

    
    override func viewDidAppear(animated: Bool) {
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Canteen")
        var error: NSError?
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [Canteen]?
        
        
        if let results = fetchedResults {
            canteen = results
            println("loading")
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        self.tableView.allowsMultipleSelectionDuringEditing = true
        
        totalq = 0
        totalp = 0.0
        
        self.tableView.reloadData()
        
        }
    
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        println("count \(canteen.count+2)")
        return canteen.count + 2
        
        
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        if (indexPath.row ==  0) {
            
           var cell = self.tableView.dequeueReusableCellWithIdentifier(
                "titleCell", forIndexPath: indexPath) as! titleCell
            return cell
            
            
        } else if ( indexPath.row == canteen.count+1) {
          var  cell = self.tableView.dequeueReusableCellWithIdentifier(
                "totalCell", forIndexPath: indexPath) as! totalCell
            cell.totalprice.text = "\(self.totalp)"
            cell.totalquantity.text = "\(self.totalq)"
            
            return cell
            
            
        }  else  {
            
            
            println("index \(indexPath.row) \(canteen[indexPath.row - 1])")
            var cell = self.tableView.dequeueReusableCellWithIdentifier(
                "itemCell", forIndexPath: indexPath) as! itemCell
            
            cell.item.text = canteen[indexPath.row - 1].item
            cell.price.text = "\(canteen[indexPath.row - 1].price)"
            cell.codeNo.text = canteen[indexPath.row - 1].code
             cell.quantity.text = "\(canteen[indexPath.row - 1].quantity)"
            cell.totalPrice.text = "\(canteen[indexPath.row - 1].totalprice)"
            
            
            self.totalq += (canteen[indexPath.row - 1].quantity).integerValue
            self.totalp += (canteen[indexPath.row - 1].totalprice).floatValue
            println("P : \(totalp) Q: \(totalq)")
            return cell
            
        }
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if ( indexPath.row ==  0 || indexPath.row ==  canteen.count+1 ) {
          //  println("index \(indexPath.row) false")
            return false
        } else {
           //  println("index \(indexPath.row) true")
        return true
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete ) {
            //add code here for when you hit delete
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            
            
            let managedContext = appDelegate.managedObjectContext!
            
            //2
            let fetchRequest = NSFetchRequest(entityName:"Canteen")
            var error: NSError?
            
            
            var predicate =  NSPredicate ()
            
            predicate  = NSPredicate(format: "code = %@", canteen[indexPath.row - 1].code )
            println("to be deleted \(canteen[indexPath.row - 1].code)")
            
            fetchRequest.predicate = predicate
            
            let fetchedResults =
            managedContext.executeFetchRequest(fetchRequest,
                error: &error) as! [Canteen]?
            
           
            self.tableView!.beginUpdates()
          
            
            managedContext.deleteObject(fetchedResults![0])
            
            
            
            
            self.tableView!.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
            
            totalp = 0
            totalq = 0
            
            fetchRequest.predicate = nil
            
            let fetchedResultsReload = managedContext.executeFetchRequest(fetchRequest,
                error: &error) as! [Canteen]?
            
            
            
            if  let results = fetchedResultsReload {
                canteen = results
                println(canteen)
                println("loading")
            } else {
                println("Could not fetch \(error), \(error!.userInfo)")
            }
            self.tableView!.reloadData()
            self.tableView!.endUpdates()
            
            
            
            println("Deleted")
        }
        
        
    }
    
}