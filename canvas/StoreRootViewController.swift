//
//  StoreRootViewController.swift
//  canvas
//
//  Created by sidhartha madipalli on 8/23/15.
//  Copyright (c) 2015 Canvas Electronic. All rights reserved.
//

import UIKit

class StoreRootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonClick(sender: UIBarButtonItem) {
        var nc = self.tabBarController?.viewControllers?.first as! UINavigationController
        nc.popViewControllerAnimated(true)
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
