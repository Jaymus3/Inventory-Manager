//
//  PartTableViewController.swift
//  Inventory Manager
//
//  Created by Sturtevant Auto on 5/31/16.
//  Copyright © 2016 Sturtevant Auto. All rights reserved.
//

import UIKit

class PartTableViewController: UITableViewController, PartProtocol {
    //MARK: Properties
    var feedItems: NSArray = NSArray()
    var parts = [Part]()
    @IBOutlet var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let part = PartModel()
        part.delegate = self
        part.downloadItems()
        CarSelectionController().hasTappedGenerate = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.tableView.reloadData()
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    func loadDefaultWorksheet()
    {
        //TODO: Make this not blank.
        /*
        let noPhoto = UIImage(named: "noPhoto")!
        let grille = Part(name: "104 - Grille", photo: noPhoto, conditions: 0, make: "", model: "", year: 0, stock: "")
        let bumpfr = Part(name: "105 - Bumper (Front)", photo: noPhoto, conditions: 0, make: "", model: "", year: 0, stock: "")
        let radcore = Part(name: "109 - Radiator Core Sup", photo: noPhoto, conditions: 0, make: "", model: "", year: 0, stock: "")
        let fenderR = Part(name: "110 - Fender (Right)", photo: noPhoto, conditions: 0, make: "", model: "", year: 0, stock: "")
        let fenderL = Part(name: "110 - Fender (Left)", photo: noPhoto, conditions: 0, make: "", model: "", year: 0, stock: "")
        let headlampR = Part(name: "114 - Headlight (Right)", photo: noPhoto, conditions: 0, make: "", model: "", year: 0, stock: "")
        let headlampL = Part(name: "114 - Headlight (Left)", photo: noPhoto, conditions: 0, make: "", model: "", year: 0, stock: "")
        parts += [grille, bumpfr, radcore, fenderR, fenderL, headlampR, headlampL]
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return feedItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "PartTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PartTableViewCell
        let part: Part = feedItems[indexPath.row] as! Part
        parts += [part]
        cell.nameLabel.text = part.name
        
        if part.conditions > 111
        {
        cell.warningImage.hidden = false
        }
        else
        {
        cell.warningImage.hidden = true
        }
        
        if part.conditions == 0
        {
            cell.cellSwitch.setOn(false, animated: false)
        }
        else
        {
            cell.cellSwitch.setOn(true, animated: false)
        }


        return cell
    }
    
    
    @IBAction func buttonPressed(sender: UIButton) {
        let button = sender
        let view = button.superview!
        let cell = view.superview as! PartTableViewCell
        if cell.cellSwitch.on
        {
            cell.cellSwitch.setOn(false, animated: true)
            let stock = mainInstance.stock.stringByReplacingOccurrencesOfString(" ", withString: "%20")
            let name = cell.nameLabel.text!.stringByReplacingOccurrencesOfString(" ", withString: "%20")
            let url = NSURL (string: "http://192.168.1.38/ipodinterface/update.php?stock=" + stock + "&name=" + name + "&conditions=0");
            let requestObj = NSURLRequest(URL: url!)
            webView.loadRequest(requestObj);

        }
        else if !cell.cellSwitch.on
        {
            cell.cellSwitch.setOn(true, animated: true)
            let stock = mainInstance.stock.stringByReplacingOccurrencesOfString(" ", withString: "%20")
            let name = cell.nameLabel.text!.stringByReplacingOccurrencesOfString(" ", withString: "%20")
            let url = NSURL (string: "http://192.168.1.38/ipodinterface/update.php?stock=" + stock + "&name=" + name + "&conditions=111");
            let requestObj = NSURLRequest(URL: url!)
            webView.loadRequest(requestObj);
        }
        

    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    

    
    // Override to support editing the table view.
    /*
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            parts.removeAtIndex(indexPath.row)
            //Save
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail"
        {
            let partDetailViewController = segue.destinationViewController as! PartViewController
            if let selectedPartCell = sender as? PartTableViewCell
            {
                let indexPath = tableView.indexPathForCell(selectedPartCell)!
                let selectedPart = parts[indexPath.row]
                partDetailViewController.part = selectedPart
            }
        }
        else if segue.identifier == "AddItem"
        {
            print("Adding new part.")
        }
    }
    

    @IBAction func unWindToPartList(sender: UIStoryboardSegue)
    {
        if let sourceViewController = sender.sourceViewController as?
        PartViewController, part = sourceViewController.part
        {
            if let selectedIndexPath = tableView.indexPathForSelectedRow
            {
                parts[selectedIndexPath.row] = part
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else
            {
                let newIndexPath = NSIndexPath(forRow: parts.count, inSection: 0)
                parts.append(part)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            //Save
        }
    }
    
    //MARK: NSCoding
    }
