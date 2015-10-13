//
//  manageTablesViewController.swift
//  TipNTop Snooker Parlour
//
//  Created by Dineshkumar on 07/10/15.
//  Copyright (c) 2015 TipNTop Cue Sports. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MessageUI


public class TableManager {
    
    class var sharedInstance: TableManager {
        
        struct Static {
            static let instance: TableManager = TableManager()
        }
        return Static.instance
    }
    
    public var tables = [Table]()
    
    
    public var cost = UInt16(2.5)
    public var pdcode = 1
    public var password = "gdine89"
    
}

public class Table {
    var timeris_on : Bool
    var tableName : String
    var updateTimeFn : String
    var done : Bool
    var hasPaid : Bool
    var startTime = NSTimeInterval()
    var amount = UInt16()
    var elapsedTime = NSTimeInterval()
    var totalCost = UInt16()
    var foodCost = Float()
    var minimumcost = Float(50)
    var paid = UInt16()
    var gameType = Int()
    var gameTypeSelected: Bool = false
    var payee = Int()
    var winnerSelected = false
    var BillSummary: NSString = ""
    var boardcharge = UInt16()
    var hour = UInt16()
    var minutes = UInt16()
    var discount = NSString()
    var startTimeString = ""
    var endTimeString = ""
    var foodCharges = [foodBill]()
    var totalp = Float()
    var totalq = Int16()
    var cost_per_mintue = UInt16(2.5)
    init(name:String , updatefn:String) {
        timeris_on = false
        tableName = name
        updateTimeFn = updatefn
        done = false
        hasPaid = false
    }
}

class manageTablesViewController :  UIViewController , MFMessageComposeViewControllerDelegate , UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        
        if TableManager.sharedInstance.tables.count == 0 {
            
            TableManager.sharedInstance.tables.append(Table(name: "Table1", updatefn: "updateTime1"))
            TableManager.sharedInstance.tables.append(Table(name: "Table2", updatefn: "updateTime2"))
            TableManager.sharedInstance.tables.append(Table(name: "Table3", updatefn: "updateTime3"))
            TableManager.sharedInstance.tables.append(Table(name: "Table4", updatefn: "updateTime4"))
            
        }
        
        
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        
      /*  switch (result) {
        case MessageComposeResultCancelled:
           // NSLog(@"Cancelled");
            break;
        case MessageComposeResultFailed:
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MyApp" message:@"Unknown Error"
            delegate:self cancelButtonTitle:@”OK” otherButtonTitles: nil];
            [alert show];
            [alert release];
            break;
        case MessageComposeResultSent:
            
            break;
        default:
            break;
        }*/
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    /* Timer Display */
    
    @IBOutlet weak var timerDisplay1: UITextField!
    
    @IBOutlet weak var timerDisplay2: UITextField!
   
    @IBOutlet weak var timerDisplay3: UITextField!
   
    @IBOutlet weak var timerDisplay4: UITextField!
    
    
    /* Timer Amount Display */
    
    @IBOutlet weak var timerAmountDisplay1: UITextField!
    
    @IBOutlet weak var timerAmountDisplay2: UITextField!
    
    @IBOutlet weak var timerAmountDisplay3: UITextField!
    
    @IBOutlet weak var timerAmountDisplay4: UITextField!
    
    
    /* Customer Name*/
    
    @IBOutlet weak var nameField1: UITextField!
    
    @IBOutlet weak var nameField2: UITextField!
    
    @IBOutlet weak var nameField3: UITextField!
    
    @IBOutlet weak var nameField4: UITextField!
    
    /* Handle start and stop action */
    
    @IBAction func timerButtonPressed(sender: AnyObject) {
        
        var dateFormater = NSDateFormatter()
        
        dateFormater.timeZone = NSTimeZone()
        dateFormater.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormater.timeStyle = NSDateFormatterStyle.MediumStyle
        
        if TableManager.sharedInstance.tables[sender.tag].timeris_on == false {
            
            TableManager.sharedInstance.tables[sender.tag].timeris_on = true
            TableManager.sharedInstance.tables[sender.tag].done = false
            TableManager.sharedInstance.tables[sender.tag].hasPaid = false
            TableManager.sharedInstance.tables[sender.tag].totalCost = 0
            TableManager.sharedInstance.tables[sender.tag].amount = 0
            TableManager.sharedInstance.tables[sender.tag].foodCost = 0
            TableManager.sharedInstance.tables[sender.tag].startTime = NSDate.timeIntervalSinceReferenceDate()
            TableManager.sharedInstance.tables[sender.tag].startTimeString = "\(dateFormater.stringFromDate(NSDate()))"
            
            var controller = MFMessageComposeViewController()
            controller.delegate = self
           // MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
            if(MFMessageComposeViewController.canSendText())
            {
                controller.body = "Hello from Mugunth";
                controller.recipients = ["+919535217602"]
                controller.messageComposeDelegate = self;
              //  [self presentModalViewController:controller animated:YES];
                self.presentViewController(controller, animated: true, completion: nil)
            }
            
            let image = UIImage(named: "green.png") as UIImage?
            sender.setBackgroundImage(image, forState: UIControlState.Normal)
            var aselector = Selector()
            
            switch sender.tag {
            case 0 :
                timerAmountDisplay1.text = "50.00"
                aselector = "updateTime1"
                break;
                
            case 1:
                timerAmountDisplay2.text = "50.00"
                aselector = "updateTime2"
                break;
            
            case 2:
                timerAmountDisplay3.text  = "50.00"
                aselector = "updateTime3"
                break;
            
            case 3 :
                timerAmountDisplay4.text = "50.00"
                aselector = "updateTime4"
                break
            
            default:
                break
            
                
            }
            
            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aselector, userInfo: nil, repeats: true)
            
            
        } else {
            
            
            TableManager.sharedInstance.tables[sender.tag].endTimeString = "\(dateFormater.stringFromDate(NSDate()))"
            
            TableManager.sharedInstance.tables[sender.tag].timeris_on = false
            TableManager.sharedInstance.tables[sender.tag].endTimeString = "\(dateFormater.stringFromDate(NSDate()))"
            
            
            let image = UIImage(named: "PngMedium-Power-On-Off-Switch-red-2-14387.png") as UIImage?
            sender.setBackgroundImage(image, forState: UIControlState.Normal)
            
        }
    }
    
    func updateTime1(){
        
        if ( TableManager.sharedInstance.tables[0].timeris_on == false){
            return
        }
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        
        // Find difference between current time and start time
        TableManager.sharedInstance.tables[0].elapsedTime = currentTime - TableManager.sharedInstance.tables[0].startTime
        
        // Calculate minutes in elapsed time
        var hours = UInt16(TableManager.sharedInstance.tables[0].elapsedTime/3600.0)
        TableManager.sharedInstance.tables[0].elapsedTime -= (NSTimeInterval(hours)*3600)
        var minutes = UInt16(TableManager.sharedInstance.tables[0].elapsedTime/60.0)
        
        TableManager.sharedInstance.tables[0].elapsedTime -= (NSTimeInterval(minutes)*60)
        
        var seconds = UInt16(TableManager.sharedInstance.tables[0].elapsedTime)
        TableManager.sharedInstance.tables[0].elapsedTime -= NSTimeInterval(seconds)
        
        timerDisplay1.text = NSString(format: "%02u:%02u:%02u", hours,minutes,seconds) as String
        timerAmountDisplay1.text = NSString(format: "%u.00", TableManager.sharedInstance.tables[0].amount) as String
        if( minutes <= 20){
            TableManager.sharedInstance.tables[0].amount = 50
        } else {
           TableManager.sharedInstance.tables[0].amount = (hours * 60 * 3)+(minutes * TableManager.sharedInstance.tables[0].cost_per_mintue)
        }
        TableManager.sharedInstance.tables[0].hour = hours
        TableManager.sharedInstance.tables[0].minutes = minutes
        
    }
    
    func updateTime2(){
        
        if ( TableManager.sharedInstance.tables[1].timeris_on == false){
            return
        }
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        
        // Find difference between current time and start time
        TableManager.sharedInstance.tables[1].elapsedTime = currentTime - TableManager.sharedInstance.tables[1].startTime
        
        // Calculate minutes in elapsed time
        var hours = UInt16(TableManager.sharedInstance.tables[1].elapsedTime/3600.0)
        TableManager.sharedInstance.tables[1].elapsedTime -= (NSTimeInterval(hours)*3600)
        var minutes = UInt16(TableManager.sharedInstance.tables[1].elapsedTime/60.0)
        
        TableManager.sharedInstance.tables[1].elapsedTime -= (NSTimeInterval(minutes)*60)
        
        var seconds = UInt16(TableManager.sharedInstance.tables[0].elapsedTime)
        TableManager.sharedInstance.tables[1].elapsedTime -= NSTimeInterval(seconds)
        
        timerDisplay2.text = NSString(format: "%02u:%02u:%02u", hours,minutes,seconds) as String
        timerAmountDisplay2.text = NSString(format: "%u.00", TableManager.sharedInstance.tables[1].amount) as String
        if( minutes <= 20){
            TableManager.sharedInstance.tables[1].amount = 50
        } else {
            TableManager.sharedInstance.tables[1].amount = (hours * 60 * 3)+(minutes * TableManager.sharedInstance.tables[1].cost_per_mintue)
        }
        TableManager.sharedInstance.tables[1].hour = hours
        TableManager.sharedInstance.tables[1].minutes = minutes
        
    }
    
    func updateTime3(){
        
        if ( TableManager.sharedInstance.tables[2].timeris_on == false){
            return
        }
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        
        // Find difference between current time and start time
        TableManager.sharedInstance.tables[2].elapsedTime = currentTime - TableManager.sharedInstance.tables[0].startTime
        
        // Calculate minutes in elapsed time
        var hours = UInt16(TableManager.sharedInstance.tables[2].elapsedTime/3600.0)
        TableManager.sharedInstance.tables[2].elapsedTime -= (NSTimeInterval(hours)*3600)
        var minutes = UInt16(TableManager.sharedInstance.tables[2].elapsedTime/60.0)
        
        TableManager.sharedInstance.tables[2].elapsedTime -= (NSTimeInterval(minutes)*60)
        
        var seconds = UInt16(TableManager.sharedInstance.tables[2].elapsedTime)
        TableManager.sharedInstance.tables[2].elapsedTime -= NSTimeInterval(seconds)
        
        timerDisplay3.text = NSString(format: "%02u:%02u:%02u", hours,minutes,seconds) as String
        timerAmountDisplay3.text = NSString(format: "%u.00", TableManager.sharedInstance.tables[2].amount) as String
        if( minutes <= 20){
            TableManager.sharedInstance.tables[2].amount = 50
        } else {
            TableManager.sharedInstance.tables[2].amount = (hours * 60 * 3)+(minutes * TableManager.sharedInstance.tables[2].cost_per_mintue)
        }
        TableManager.sharedInstance.tables[2].hour = hours
        TableManager.sharedInstance.tables[2].minutes = minutes
        
    }
    
    func updateTime4(){
        
        if ( TableManager.sharedInstance.tables[3].timeris_on == false){
            return
        }
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        
        // Find difference between current time and start time
        TableManager.sharedInstance.tables[3].elapsedTime = currentTime - TableManager.sharedInstance.tables[3].startTime
        
        // Calculate minutes in elapsed time
        var hours = UInt16(TableManager.sharedInstance.tables[3].elapsedTime/3600.0)
        TableManager.sharedInstance.tables[3].elapsedTime -= (NSTimeInterval(hours)*3600)
        var minutes = UInt16(TableManager.sharedInstance.tables[3].elapsedTime/60.0)
        
        TableManager.sharedInstance.tables[3].elapsedTime -= (NSTimeInterval(minutes)*60)
        
        var seconds = UInt16(TableManager.sharedInstance.tables[3].elapsedTime)
        TableManager.sharedInstance.tables[3].elapsedTime -= NSTimeInterval(seconds)
        
        timerDisplay4.text = NSString(format: "%02u:%02u:%02u", hours,minutes,seconds) as String
        timerAmountDisplay4.text = NSString(format: "%u.00", TableManager.sharedInstance.tables[3].amount) as String
        if( minutes <= 20){
            TableManager.sharedInstance.tables[3].amount = 50
        } else {
            TableManager.sharedInstance.tables[3].amount = (hours * 60 * 3)+(minutes * TableManager.sharedInstance.tables[3].cost_per_mintue)
        }
        TableManager.sharedInstance.tables[3].hour = hours
        TableManager.sharedInstance.tables[3].minutes = minutes
        
    }
   
    
    @IBAction func addCart(sender: AnyObject) {
    }
}