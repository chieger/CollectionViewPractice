//
//  DetailViewController.swift
//  CollectionViewPractice
//
//  Created by Charles Hieger on 12/1/15.
//  Copyright © 2015 Charles Hieger. All rights reserved.
//

import UIKit
import Photos

class DetailViewController: UIViewController {

    var assetCollection: PHAssetCollection!
    // PHFetchResult is like an array
    var photosAsset: PHFetchResult!
    var index: Int!
    
    @IBOutlet weak var detailImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       
        displayPhoto()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressCancel(sender: AnyObject) {
    
    navigationController?.popViewControllerAnimated(true)
    }
    
    func displayPhoto() {
        let imageManager = PHImageManager.defaultManager()
        let asset = photosAsset[index] as! PHAsset
        let ID = imageManager.requestImageForAsset(asset, targetSize: PHImageManagerMaximumSize, contentMode: .AspectFit, options: nil) { (result: UIImage?, info: [NSObject : AnyObject]?) -> Void in
            self.detailImageView.image = result
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
