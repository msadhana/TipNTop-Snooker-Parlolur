//
//  TopUpViewController.swift
//  TipNTop Snooker Parlour
//
//  Created by Dineshkumar on 02/06/15.
//  Copyright (c) 2015 TipNTop Cue Sports. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import AVFoundation

class TopUpViewController : UIViewController , AVCaptureMetadataOutputObjectsDelegate, UIPickerViewDelegate , UIPickerViewDataSource, UITextFieldDelegate{

   
    
    
    
    @IBOutlet weak var memberDetailsDisplay: UITextView!
    
   
    
    
    @IBOutlet var memberid: UITextField!
    
    func updateCustomerName() {
        
        var members = [Member]()
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Member")
        var predicate: NSPredicate = NSPredicate(format: "memberid == %@", memberid.text)
        println("\(memberid.text)")
        
        fetchRequest.predicate =  predicate
        var error: NSError?
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [Member]?
        
        
        if let results = fetchedResults {
            //   members = results
            if (results.count != 0){
                var managedObject = results[0]
                println("Found")
                
                println("name: \(results[0].memberid)")
                memberDetailsDisplay.text = "Member Id          Name          Balance  \n==========================================================\n\(results[0].memberid)           \(results[0].name)                \(results[0].balance) \n \n\nPhone Number:\(results[0].phoneno)"
                
            } else {
                memberDetailsDisplay.text = "Couldnt find Member!!!"
            }
        } else {
            
            println("Couldnt find")
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        

        
    }
    
    @IBAction func memberIdDidEnd(sender: AnyObject) {
       updateCustomerName()
        
    }
    
    
    @IBOutlet weak var discountPicker: UIPickerView!
   
    @IBOutlet weak var discount: UITextField!
    
    @IBOutlet weak var topUpAMount: UITextField!
    
    @IBAction func topUp(sender: AnyObject) {
        
        if(topUpAMount.text != "0") {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Member")
        var predicate: NSPredicate = NSPredicate(format: "memberid == %@", memberid.text)
        println("\(memberid.text)")
        
        fetchRequest.predicate =  predicate
        var error: NSError?
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [Member]?
        
        
        
        if let results = fetchedResults {
            //   members = results
            if (results.count != 0){
                var managedObject = results[0]
                println("Found")
                
                println("name: \(results[0].memberid)")
                var balance = results[0].balance.integerValue + (topUpAMount.text as NSString).integerValue
                
                if discountPercentage != 0 {
                    balance += ((topUpAMount.text as NSString).integerValue * discountPercentage) / 100
                }

                
                results[0].balance = NSNumber(integer: balance)
                
                managedContext.save(nil)
                memberDetailsDisplay.text = "Member Id          Name          Balance  \n==========================================================\n\(results[0].memberid)           \(results[0].name)                \(results[0].balance) \n \n\nPhone Number:\(results[0].phoneno)"
                
                
            } else {
                 memberDetailsDisplay.text = "Couldnt find Member!!!"
            }
        } else {
           
            println("Couldnt find")
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        
        } else {
            println("Please enter amount")
            popupAlert("Please enter value to Top Up", self)
        }


    }
    
    var discountPercentage = 50
    
    override func viewDidAppear(animated: Bool) {
        
        discount.text = "\(discountPercentage) %"
        
        discountPicker.hidden = true
        
        discount.delegate = self
        discount.inputView = discountPicker
    }
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    // Added to support different barcodes
    let supportedBarCodes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode]
    

    @IBAction func scanQRcode(sender: AnyObject) {
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        var error:NSError?
        let input: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error)
        
        if (error != nil) {
            // If any error occurs, simply log the description of it and don't continue any more.
            println("\(error?.localizedDescription)")
            return
        }
        
        // Initialize the captureSession object.
        captureSession = AVCaptureSession()
        // Set the input device on the capture session.
        captureSession?.addInput(input as! AVCaptureInput)
        
        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        // Set delegate and use the default dispatch queue to execute the call back
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = supportedBarCodes
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        
        videoPreviewLayer?.frame = CGRect(x: sender.frame.origin.x , y: sender.frame.origin.y + 30, width: 300, height: 300)
        
        
        view.layer.addSublayer(videoPreviewLayer)
        
        // Start video capture.
        captureSession?.startRunning()
        
        // Move the message label to the top view
        // view.bringSubviewToFront(messageLabel)
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubviewToFront(qrCodeFrameView!)
        
        println("Cancel button")
        

    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
            // messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        // Here we use filter method to check if the type of metadataObj is supported
        // Instead of hardcoding the AVMetadataObjectTypeQRCode, we check if the type
        // can be found in the array of supported bar codes.
        if supportedBarCodes.filter({ $0 == metadataObj.type }).count > 0 {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds
            
            if metadataObj.stringValue != nil {
                // messageLabel.text = metadataObj.stringValue
                // launchApp(metadataObj.stringValue)
            
                    memberid.text = "TNT\(metadataObj.stringValue)"
                    updateCustomerName()
               
                // return
                captureSession?.stopRunning()
                videoPreviewLayer?.removeFromSuperlayer()
                qrCodeFrameView?.removeFromSuperview()
                
                
            }
        }
    }
    

    @IBAction func cancelScanner(sender: AnyObject) {
        
        captureSession?.stopRunning()
        videoPreviewLayer?.removeFromSuperlayer()
        
        qrCodeFrameView?.removeFromSuperview()
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return 20
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
            return ("\(row  * 5)%")
            
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
            self.discountPercentage = row  * 5
            discount.text = "\(row * 5) %"
        
      
        discountPicker.hidden = true
        
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let pickerLabel = UILabel()
        var titleData = ""
        var hue = CGFloat()
        
        
            titleData = "\(row * 5)%"
            hue = CGFloat(row)/CGFloat(20)
        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        
        pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 0.90, brightness:1.0, alpha: 0.5)
        pickerLabel.textAlignment = .Center
        return pickerLabel
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
       
        discountPicker.hidden = false
        
        
        return false
    }



}