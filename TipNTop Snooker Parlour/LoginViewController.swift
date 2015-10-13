//
//  LoginViewController.swift
//  TipNTop Snooker Parlour
//
//  Created by Dineshkumar on 11/05/15.
//  Copyright (c) 2015 TipNTop Cue Sports. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MessageUI



public class Users {
    
    class var sharedInstance: Users {
        
        struct Static {
            static let instance: Users = Users()
        }
        return Static.instance
    }
    
    public var admin = "admin"
    public var adminPwd = "admin"
    public var root = "root"
    public var rootPwd = "root"
    
}

class LoginViewControler: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        
        image.contentMode = UIViewContentMode.ScaleAspectFit
        
    }
    
    @IBAction func editingdidend(sender: AnyObject) {
        println("editingdidend")
        var alert1 = UIAlertController(title: "Incorrect User Name or Password",
            message: " ",
            preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Ok",
            style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        
        alert1.addAction(cancelAction)
        
        
        if (username.text == "admin"){
            if (password.text == "admin"){
                self.performSegueWithIdentifier("adminView", sender: self)
            } else {
                presentViewController(alert1,
                    animated: true,
                    completion: nil)
                
            }
            
        } else if (username.text == "root"){
            if (password.text == "root"){
                self.performSegueWithIdentifier("rootView", sender: self)
            } else {
                presentViewController(alert1,
                    animated: true,
                    completion: nil)
            }
        }  else {
            presentViewController(alert1,
                animated: true,
                completion: nil)
            
        }

    }
    
    
}