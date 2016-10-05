//
//  ViewController.swift
//  ImgGurSwift
//
//  Created by Balaji on 08/05/16.
//  Copyright © 2016 Synchronoss. All rights reserved.
//

import UIKit
import MBProgressHUD
import AlamofireImage

/*!
 * Enumeration used for Collection View Mode,
 * that is List View or Grid View.
 */
enum UICollectionViewMode  :Int {
    case Grid = 0
    case List
}

/*!
 * Enumeration for Gallery Sort Options
 */
enum Sort : String {
    case Viral = "viral"
    case Top = "top"
    case Time = "time"
}

/*!
 * Enumeration for Gallery Section options
 */
enum Section :String {
    case Hot = "hot"
    case Top = "top"
    case User = "user"
}

/*!
 * Enumeration for Gallery window options
 */
enum Window : String {
    case Day = "day"
    case Week = "week"
    case Month = "month"
    case Year = "year"
    case All = "all"
}

/*
 @description Class to show Gallery
 */

class ViewController: UIViewController  {
    
    let GridCellIdentifier = "GridCell"
    let ListCellIdentifier = "ListCell"
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //private variable
    var feedArray : Array<Gallery>?
    var sortOption : String?
    var section : String?
    var window : String?
    
    var viewMode : UICollectionViewMode = .Grid
    var seletedSection : Section = .Hot
    var selectedSort : Sort = .Viral
    var selectedWindow : Window = .Day
    var selectedIndexPath : NSIndexPath?
    var shouldShowViral : Bool = false
    var HUD : MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.feedArray = []
        self.collectionView.setContentOffset(CGPointMake(0, 0), animated: true)
        
        if let session = UserSession().userSession() {
            print(session.debugDescription)
            fetchData()
        }else {
            showAuthorizationWarningAlert()
        }
        self.addObservers()
        self.updateCollectionViewFlowlayout()
    }
    
    @IBAction func reloadGalleryData(sender: AnyObject) {
        fetchData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    
    private func addObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(ViewController.didAuthenticationComplete(_:)),
                                                         name: AuthenticationDidCompleteNotification,
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(ViewController.didChangeOrientation(_:)),
                                                         name: UIDeviceOrientationDidChangeNotification,
                                                         object: nil)
    }
    
    
    private func removedObservers() {
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: AuthenticationDidCompleteNotification,
                                                            object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name: UIDeviceOrientationDidChangeNotification,
                                                            object: nil)
    }
    
    func fetchData() {
        dispatch_async(dispatch_get_main_queue(), {
            self.HUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            self.HUD.mode = .Indeterminate
            self.HUD.labelText = "Loading gallery"
        });
        Gallery.fetchGallery { (gallery) in
            self.feedArray = gallery
            dispatch_async(dispatch_get_main_queue(), {
                self.HUD.hide(true)
                self.collectionView.reloadData()
            })
        }
    }
    
    func didAuthenticationComplete(notification:NSNotification) {
        print(notification)
        fetchData()
    }
    
    func didChangeOrientation(notification: NSNotification) {
        self.updateCollectionViewFlowlayout()
    }
    
    func showAuthorizationWarningAlert() {
        let authAlert = UIAlertController(title: NSLocalizedString("AUTHORIZATION_REQUIRED_ALERT_TITLE", comment: "Alert title"),
                                          message: NSLocalizedString("AUTHORIZATION_REQUIRED_ALERT_MESSAGE", comment: "Message"),
                                          preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Authorize", style: .Default) { (action) in
            APIManager.sharedInstance.authorizeApp()
        }
        authAlert.addAction(action)
        self.presentViewController(authAlert, animated: true, completion: nil)
    }
    
}


extension ViewController : UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView (collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if let image = self.feedArray?[indexPath.row] {
            
            let idiom = UIDevice.currentDevice().userInterfaceIdiom
            if (idiom == .Pad) {
                if (self.viewMode == .Grid) {
                    let width = min(image.width!,160), height = min(image.height!, 250)
                    return CGSizeMake(CGFloat(width),CGFloat(height))
                }
                return CGSizeMake(120,70);
            }else if (idiom == .Phone) {
                if (self.viewMode == .Grid) {
                    let width = min(image.width!,160), height = min(image.height!,250)
                    return CGSizeMake(CGFloat(width),CGFloat(height))
                }
                return CGSizeMake(120,70);
            }
        }
        return CGSizeZero;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.feedArray?.count)!
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell : ImageCollectionViewCell! = nil
        if (self.viewMode == .Grid) {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(GridCellIdentifier, forIndexPath: indexPath) as! ImageCollectionViewCell
        }else {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(ListCellIdentifier, forIndexPath: indexPath) as! ImageCollectionViewCell
        }
        
        if let galleryImage = self.feedArray?[indexPath.row] {
            cell.titleLabel.text = galleryImage.title;
            cell.pointsLabel.text = "Points \(galleryImage.points)"
            cell.titleBGView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
            if let urlString = galleryImage.link {
                
                let URL = NSURL(string:urlString)!
                cell.imageView.af_setImageWithURL(URL, placeholderImage: nil, filter: nil, imageTransition: UIImageView.ImageTransition.CrossDissolve(0.2), completion: { (response) in
                    print("\(response.request?.URLString) response \(response.response?.statusCode)")
                })
            }
        }        
        
        return cell;
    }
    
    func updateCollectionViewFlowlayout() {
        let layout = CHTCollectionViewWaterfallLayout()
        let idiom = UIDevice.currentDevice().userInterfaceIdiom
        if idiom == .Pad {
            let orientation = UIApplication.sharedApplication().statusBarOrientation
            if self.viewMode == .Grid {
                if orientation == .Portrait {
                    layout.columnCount = 3
                }else {
                    layout.columnCount = 4
                }
            }else {
                layout.columnCount = 2
            }
        }else if idiom == .Phone {
            let orientation = UIApplication.sharedApplication().statusBarOrientation
            if self.viewMode == .Grid {
                if orientation == .Portrait {
                    layout.columnCount = 2
                }else {
                    layout.columnCount = 3
                }
            }else {
                if orientation == .Portrait {
                    layout.columnCount = 1
                }else {
                    layout.columnCount = 2
                }
            }
        }
        layout.minimumColumnSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        layout.itemRenderDirection = .CHTCollectionViewWaterfallLayoutItemRenderDirectionLeftToRight
        self.collectionView.collectionViewLayout = layout
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
}