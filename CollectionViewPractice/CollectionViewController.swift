//
//  ViewController.swift
//  CollectionViewPractice
//
//  Created by Charles Hieger on 12/1/15.
//  Copyright © 2015 Charles Hieger. All rights reserved.
//

import UIKit
import Photos

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var albumName = "myApp"
    
    var albumFound: Bool = false
    var assetCollection: PHAssetCollection!
    var photosAsset: PHFetchResult!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        // Check if the folder exists, if not, create it
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        
        let collection = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
        if collection.firstObject != nil {
            
            // Found the album
            print("album already exists")
            albumFound = true
            assetCollection = collection.firstObject as! PHAssetCollection
        } else {
            // Create folder
            print("Folder, \(albumName) not found")
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({ () -> Void in
                PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(self.albumName)
                }, completionHandler: { (success: Bool, error: NSError?) -> Void in
                    if error == nil {
                        print("You created an album called \(self.albumName)")
                        self.albumFound = true
                    } else {
                        print("error \(error?.localizedDescription)")
                    }
            })
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if assetCollection != nil {
            // Fetch the photos from collection
            photosAsset = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
            collectionView.reloadData()
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count = 0
        if photosAsset != nil {
            count = photosAsset.count
        }
        return count
        
    }
    
    // UICollectionViewDataSource methods
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        
        let asset = photosAsset[indexPath.item] as! PHAsset
        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: .AspectFill, options: nil) { (result: UIImage?, info:[NSObject : AnyObject]?) -> Void in
            cell.setThumbnailImage(result!)
        }
        
        
        return cell
        
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 4
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let detailViewController = segue.destinationViewController as! DetailViewController
            let indexPath = collectionView.indexPathForCell(sender as! UICollectionViewCell)
            detailViewController.index = indexPath?.item
            
            detailViewController.assetCollection = self.assetCollection
            detailViewController.photosAsset = self.photosAsset
            
        }
    }
    
}

