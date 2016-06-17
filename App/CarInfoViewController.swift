//
//  CarInfoViewController.swift
//  Inventory Manager
//
//  Created by Sturtevant Auto on 6/14/16.
//  Copyright © 2016 Sturtevant Auto. All rights reserved.
//

import UIKit

class CarInfoViewController: UIViewController {
    
    //MARK: Variables
    @IBOutlet weak var carYear: UILabel!
    @IBOutlet weak var carMake: UILabel!
    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var carTitle: UINavigationItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        carYear.text = mainInstance.year
        carMake.text = mainInstance.make
        carModel.text = mainInstance.model
        carTitle.title = mainInstance.year + " " + mainInstance.make + " " + mainInstance.model

        // Do any additional setup after loading the view.
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
