//
//  CarSelectionController.swift
//  Inventory Manager
//
//  Created by Sturtevant Auto on 6/1/16.
//  Copyright © 2016 Sturtevant Auto. All rights reserved.
//

import UIKit

class CarSelectionController: UIViewController, UITextFieldDelegate {
    //MARK: Variables
    @IBOutlet weak var makeField: UITextField!
    @IBOutlet weak var modelField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var stockField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var webView: UIWebView!
    var keyBoardUp = false
    var dontKeyUp = false
    var hasTappedGenerate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CarSelectionController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CarSelectionController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        makeField.delegate = self
        modelField.delegate = self
        stockField.delegate = self
        yearField.delegate = self
        switch (self.segmentedControl.selectedSegmentIndex)
        {
        case 0:
            loadButton.setTitle("Load parts list", forState: UIControlState.Normal)
            break;
        case 1:
            loadButton.setTitle("Generate new car", forState: UIControlState.Normal)
            break;
        default:
            break;
        }
        // Do any additional setup after loading the view.
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if(!keyBoardUp && !dontKeyUp)
            {
            self.view.frame.origin.y -= keyboardSize.height / 2
            keyBoardUp = true
            }
            
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()  {
            if(!dontKeyUp)
            {
            self.view.frame.origin.y += keyboardSize.height / 2
            keyBoardUp = false
            }
            else if(dontKeyUp)
            {
                dontKeyUp = false
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField == makeField)
        {
            dontKeyUp = true
        }
    }
    func textFieldDidEndEditing(textField: UITextField) {
        loadButton.enabled = false
        checkValidityOfTextFields()
        
    }
    
    func checkValidityOfTextFields()
    {
        switch (self.segmentedControl.selectedSegmentIndex)
        {
        case 0:
            if(stockField.hasText())
            {
                loadButton.enabled = true
            }
            break;
        case 1:
            if(makeField.hasText() && modelField.hasText() && yearField.hasText() && stockField.hasText())
            {
                loadButton.enabled = true
            }
            break;
        default:
            break;
        }
    }
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch (self.segmentedControl.selectedSegmentIndex)
            {
            case 0:
                stackView.hidden = true
                loadButton.setTitle("Load parts list", forState: UIControlState.Normal)
                loadButton.enabled = false
                checkValidityOfTextFields()
                break;
            case 1:
                stackView.hidden = false
                loadButton.setTitle("Generate new car", forState: UIControlState.Normal)
                loadButton.enabled = false
                checkValidityOfTextFields()
                break; 
            default: 
                break; 
            } 
        }
    @IBAction func buttonPressed(sender: UIButton) {
        switch (self.segmentedControl.selectedSegmentIndex)
        {
        case 0:
            print("Load")
            mainInstance.stock = stockField.text!
            mainInstance.make = makeField.text!
            mainInstance.model = modelField.text!
            mainInstance.year = yearField.text!
            print(mainInstance.stock)
            break;
        case 1:
            if(!hasTappedGenerate)
            {
                let urlend = makeField.text! + "&model=" + modelField.text! + "&year=" + yearField.text! + "&stock=" + stockField.text!
                let url = NSURL (string: "http://192.168.1.38/ipodinterface/newcar.php?make=" + urlend);
                print(url)
                let requestObj = NSURLRequest(URL: url!)
                print("Made object")
                webView.loadRequest(requestObj);
            let alertController = UIAlertController(title: "Success!", message:
                "Car generated successfully!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            loadButton.setTitle("Load generated car", forState: UIControlState.Normal)
            hasTappedGenerate = true
            mainInstance.stock = stockField.text!
            mainInstance.make = makeField.text!
            mainInstance.model = modelField.text!
            mainInstance.year = yearField.text!
            }
            break;
        default:
            break;
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
