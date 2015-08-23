//
//  StoreDetailViewController.swift
//  canvas
//
//  Created by sidhartha madipalli on 8/23/15.
//  Copyright (c) 2015 Canvas Electronic. All rights reserved.
//

import UIKit


class StoreDetailViewController: UIViewController {

    var toPass:Int!
    @IBOutlet weak var storeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeImage.image = UIImage(named:"\(toPass + 1)")
        self.title = "Item \(toPass)"
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
