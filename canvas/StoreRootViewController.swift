//
//  StoreRootViewController.swift
//  canvas
//
//  Created by sidhartha madipalli on 8/23/15.
//  Copyright (c) 2015 Canvas Electronic. All rights reserved.
//

import UIKit

class StoreRootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var storeTableView: UITableView!
    
    let storeCellIdentifier = "StoreCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeTableView.delegate = self
        storeTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonClick(sender: UIBarButtonItem) {
        var nc = self.tabBarController?.viewControllers?.first as! UINavigationController
        nc.popViewControllerAnimated(true)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier(storeCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        
        var imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: "\(indexPath.row + 1)")
        imageView.layer.cornerRadius = 18.0
        imageView.clipsToBounds = true
        
        var titleLabel = cell.viewWithTag(2) as! UILabel
        titleLabel.text = "Item \(indexPath.row)"
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell , indexPath = storeTableView.indexPathForCell(cell){
            var storeDetailViewController = segue.destinationViewController as! StoreDetailViewController
            storeDetailViewController.toPass = indexPath.row
        }
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
