//
//  AlbumsCollectionViewController.swift
//  canvas
//
//  Created by sidhartha madipalli on 8/20/15.
//  Copyright (c) 2015 Canvas Electronic. All rights reserved.
//

import UIKit

let reuseIdentifier = "AlbumsCell"
var isHidden:Bool = false
private var selectedPhotos = [String]()
private var toolBar:UIToolbar!


class AlbumsCollectionViewController: UICollectionViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.collectionView!.registerClass(AlbumsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        //Right Navigation Buttons
        var addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonTap:")
        var selectButton = UIBarButtonItem(title: "Select", style: .Plain, target: self, action: "selectButtonTap:")
        self.navigationItem.setRightBarButtonItems([selectButton,addButton],animated:true)
        
        //set Toolbar
        var play = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: "addButtonTap:")
        play.enabled = false
        var delete = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "addButtonTap:")
        delete.enabled = false
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        toolBar = UIToolbar(frame: self.tabBarController!.tabBar.frame)
        toolBar.setItems([play,flexSpace,delete], animated: true)
        toolBar.backgroundColor = UIColor.clearColor()
        
        self.view.addSubview(toolBar!)
    }
    
    func addButtonTap(sender:UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var albumsAddViewController = storyBoard.instantiateViewControllerWithIdentifier("albumsAddViewController") as! UIViewController
        self.presentViewController(albumsAddViewController, animated: true, completion: nil)
    }
    
    func selectButtonTap(sender:UIButton) {
        var selectButton = self.navigationItem.rightBarButtonItems?.first as! UIBarButtonItem
        
        if(isHidden){
            self.tabBarController?.tabBar.hidden = !isHidden
            selectButton.title = "Select"
            selectButton.style = UIBarButtonItemStyle.Plain
            selectedPhotos.removeAll(keepCapacity: false)
            
            for indexPath in collectionView!.indexPathsForSelectedItems(){
                if let index = indexPath as? NSIndexPath{
                    deselectAtIndexPath(index)
                }
            }
            
        }
        else{
            self.tabBarController?.tabBar.hidden = !isHidden
            selectButton.title = "Done"
            selectButton.style = UIBarButtonItemStyle.Done
            
        }
        collectionView?.allowsMultipleSelection = !isHidden
        isHidden = !isHidden
    }
    
    func deselectAtIndexPath(indexPath:NSIndexPath){
        if let cell = collectionView!.cellForItemAtIndexPath(indexPath) as? AlbumsCollectionViewCell {
            cell.albumsLabel.backgroundColor = UIColor.groupTableViewBackgroundColor()
            
            if let item = find(selectedPhotos, cell.albumsLabel.text!){
                selectedPhotos.removeAtIndex(item)
            }
            
        }
        handleBarButtonItems()
    }

    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    func    handleBarButtonItems(){
        if(selectedPhotos.count > 0 ){
            if let button = toolBar.items!.first as? UIBarButtonItem{
                button.enabled = true
            }
            if let button = toolBar.items!.last as? UIBarButtonItem{
                button.enabled = true
            }
        }
        else{
            if let button = toolBar.items!.first as? UIBarButtonItem{
                button.enabled = false
            }
            if let button = toolBar.items!.last as? UIBarButtonItem{
                button.enabled = false
            }
        }
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if(isHidden){
            if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? AlbumsCollectionViewCell {
                cell.albumsLabel.backgroundColor = UIColor.grayColor()
                cell.selected = true
                selectedPhotos.append(cell.albumsLabel.text!)
            }
            handleBarButtonItems()
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        deselectAtIndexPath(indexPath)
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if(!isHidden){
            return true
        }
        return false
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UICollectionViewCell , indexPath = collectionView?.indexPathForCell(cell){
            var albumsSingleViewController = segue.destinationViewController as! AlbumsSingleViewController
            albumsSingleViewController.toPass = indexPath.row
        }
    }
    
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AlbumsCollectionViewCell
        
        
        // Configure the cell
        
        cell.albumsLabel.text = "Album \(indexPath.row)"
        cell.albumsImage.image = UIImage(named: "\(indexPath.row + 1)")
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2.0
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var size = (collectionView.bounds.size.width / 2 ) - 2
        if( UIDevice.currentDevice().userInterfaceIdiom == .Pad ){
            size = (collectionView.bounds.size.width / 3) - 4
        }
        return CGSizeMake(size, size)
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
