//
//  FhooderViewController.swift
//  Fhood
//
//  Created by Young-hu Kim on 6/29/15.
//  Copyright (c) 2015 Fhood LLC. All rights reserved.
//

import UIKit



class FhooderViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource  {
    
    
    
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var spoonRating: UIImageView!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var restaurantType: UILabel!
    @IBOutlet weak var fhooderAddress: UILabel!
    @IBOutlet weak var fhooderDistance: UILabel!
    @IBOutlet weak var pickupSign: UILabel!
    @IBOutlet weak var eatinSign: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var openNowOrClose: UILabel!
    
    var arrImages : NSArray = []
    var arrPrice : [Double]  = []
    var formatter = NSNumberFormatter()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedImage : Int = 0
    var selectedRow2 : Int = 0
    
    var arrItemCount : [Int] = []
    var itemSum : Double = 0
    var quantityLabel : Int = 0
    
    var itemReceipt : [String] = []
    var qtyReceipt : [Int] = []
    var priceReceipt : [Double] = []
    
    var newTotalItemPrice : Double = 0
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var TableView3: UITableView!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var receiptView: UIView!
    
    @IBOutlet var detailView: UIView!
    @IBOutlet var detailTitle: UILabel!
    @IBOutlet var detailImage: UIImageView!
    @IBOutlet var detailPrice: UILabel!
    @IBOutlet var detailQuantity: UILabel!
    @IBOutlet var detailStepper: UIStepper!
    @IBOutlet var detailInstructions: UITextField!
    @IBOutlet var detailBackImage: UIImageView!
    @IBOutlet var detailIngredients: UILabel!


    
    @IBOutlet weak var dimView2: UIView!
    @IBOutlet weak var finalView: UIView!
    
    @IBOutlet weak var totalDue: UILabel!
    @IBOutlet weak var finalReminder: UILabel!
    

    @IBOutlet weak var quantityOne: UILabel!
    @IBOutlet weak var quantityTwo: UILabel!
    @IBOutlet weak var quantityThree: UILabel!
    @IBOutlet weak var quantityFour: UILabel!
    @IBOutlet weak var quantityFive: UILabel!
    @IBOutlet weak var quantitySix: UILabel!
    @IBOutlet weak var quantitySeven: UILabel!
    
    
    @IBOutlet weak var itemOne: UILabel!
    @IBOutlet weak var itemTwo: UILabel!
    @IBOutlet weak var itemThree: UILabel!
    @IBOutlet weak var itemFour: UILabel!
    @IBOutlet weak var itemFive: UILabel!
    @IBOutlet weak var itemSix: UILabel!
    @IBOutlet weak var itemSeven: UILabel!

    
    
    @IBOutlet weak var priceOne: UILabel!
    @IBOutlet weak var priceTwo: UILabel!
    @IBOutlet weak var priceThree: UILabel!
    @IBOutlet weak var priceFour: UILabel!
    @IBOutlet weak var priceFive: UILabel!
    @IBOutlet weak var priceSix: UILabel!
    @IBOutlet weak var priceSeven: UILabel!

    
    
    var tableCellList : NSArray = ["Reviews", "Photos", "Send messages", "About the Fhooder"]
    var tableCellImage : NSArray = ["reviews", "photos", "messages", "about"]
    
    
    // Right insets for Iphone 6 plus = 195.0, Iphone 6 = 234.0, Iphone 5 = 290
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 234.0)
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        fhooderOne()
        
        self.shopName.text = variables.name!
        self.spoonRating.image = UIImage(named: variables.ratingInString!)
        self.reviewCount.text = "\(variables.reviews!) Reviews"
        self.restaurantType.text = variables.foodType!
        self.fhooderAddress.text = variables.address
        self.fhooderDistance.text = "(\(variables.distance!) miles)"
        self.pickupSign.hidden = !variables.pickup!
        self.eatinSign.hidden = !variables.eatin!
        self.phoneNumber.text = variables.phoneNum!
        
        var newOpenMinute: String
        var newCloseMinute: String
        
        if variables.timeOpenMinute < 10 {
            newOpenMinute = "0\(String(variables.timeOpenMinute!))"
        }
        else {
            newOpenMinute = String(variables.timeOpenMinute!)
        }
        
        if variables.timeCloseMinute < 10 {
            newCloseMinute = "0\(String(variables.timeCloseMinute!))"
        }
        else {
            newCloseMinute = String(variables.timeCloseMinute!)
        }
        
        if variables.isOpen == true {
            self.openNowOrClose.text = "Open Now; Closes at \(variables.timeCloseHour!):\(newCloseMinute) \(variables.timeCloseAmpm!)"
        }
        else {
            self.openNowOrClose.text = "Closed; Opens at \(variables.timeOpenHour!):\(newOpenMinute) \(variables.timeOpenAmpm!)"
        }
        
        self.arrImages = variables.itemNames!
        self.arrPrice = variables.itemPrices!
        self.arrItemCount = variables.itemCount!
        
        // Logo
        let logo = UIImage(named: "FhoodLogo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        // TableView Delegate
        self.TableView3.delegate = self
        self.TableView3.dataSource = self

        self.TableView3.layoutMargins = UIEdgeInsetsZero
        
        // Currency formatter
        self.formatter.numberStyle = .CurrencyStyle
        
        
        // Time Picker
        self.timePicker.datePickerMode = UIDatePickerMode.Time // use time only
        let currentDate = NSDate()  // get the current date
        let newDate = NSDate(timeInterval: (15 * 60), sinceDate: currentDate)  // add 15 minutes
        self.timePicker.minimumDate = newDate // set the current date/time as a minimum
        self.timePicker.date = newDate // defaults to current time but shows how to use it.
        
        
        // Initialize totalItemPrice
        variables.totalItemPrice = 0
        
        
        // Detail view image tap to see ingredients
        let tapGesture = UITapGestureRecognizer(target: self, action: "imageFlipped:")
        self.detailImage.addGestureRecognizer(tapGesture)
        self.detailImage.userInteractionEnabled = true
        
        let tapGestureBack = UITapGestureRecognizer(target: self, action: "imageFlipBack:")
        self.detailBackImage.addGestureRecognizer(tapGestureBack)
        self.detailBackImage.userInteractionEnabled = true

    }
    
    // Detail image flip to show ingredients
    func imageFlipped(gesture: UIGestureRecognizer) {
        
//        self.detailImage.translatesAutoresizingMaskIntoConstraints = true
        
        
            UIView.transitionFromView(self.detailImage, toView: self.detailBackImage, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
            
            self.detailBackImage.alpha = 1
            self.detailIngredients.alpha = 1
        
    }
    
    func imageFlipBack(gesture: UIGestureRecognizer) {
        
//        self.detailBackImage.translatesAutoresizingMaskIntoConstraints = true
        
        
            UIView.transitionFromView(self.detailBackImage, toView: self.detailImage, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
            
            self.detailBackImage.alpha = 0
            self.detailIngredients.alpha = 0
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    
    // CollectionView
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let coCell = collectionView.dequeueReusableCellWithReuseIdentifier("collCell", forIndexPath: indexPath) as! CollectionViewCell
        
        self.newTotalItemPrice = 0
        
        coCell.pinImage.image = UIImage(named: (arrImages.objectAtIndex(indexPath.item) as! String) )
        
        coCell.foodName.text = arrImages.objectAtIndex(indexPath.item) as? String
        coCell.foodName.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        coCell.foodName.textColor = UIColor.whiteColor()
        
        coCell.foodPrice.text = formatter.stringFromNumber(arrPrice[indexPath.item])
        coCell.foodPrice.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        coCell.foodPrice.textColor = UIColor.whiteColor()
        
        
        if self.arrItemCount[indexPath.item] == 0 {
            coCell.foodQuantity.text = ""
            coCell.foodQuantity.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        
            coCell.subtractButton.alpha = 0
            coCell.subtractButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        }
        else {
            coCell.foodQuantity.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            coCell.foodQuantity.text = " x " + "\(Int(arrItemCount[indexPath.item]))"
            coCell.subtractButton.alpha = 0.8
            coCell.subtractButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
        
        
        coCell.subtractButton.layer.setValue(indexPath.item, forKey: "index")
        coCell.subtractButton.addTarget(self, action: "subtractItem:", forControlEvents: UIControlEvents.TouchUpInside)
        
        if variables.totalItemPrice == 0 {
            self.doneButton.alpha = 0
            self.totalPrice.text = "$0.00"
        }
        else {
            
            for var i = 0; i < variables.itemCount!.count; i++ {
                self.newTotalItemPrice += (Double(arrItemCount[i]) * arrPrice[i])
            }
            
            variables.totalItemPrice! = self.newTotalItemPrice
            self.totalPrice.text = formatter.stringFromNumber(variables.totalItemPrice!)
            
            self.doneButton.alpha = 1
            self.doneButton.addTarget(self, action: "donePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    
        return coCell
    }
    
    
    func subtractItem (sender: UIButton) {
        
        let i : Int = (sender.layer.valueForKey("index")) as! Int
        
        self.arrItemCount[i]--
        self.newTotalItemPrice = 0
        
        // Reset the list on the ReceiptView
        if self.arrItemCount[i] == 0 {
            self.quantityOne.text = nil
            self.itemOne.text = nil
            self.priceOne.text = nil
        
            self.quantityTwo.text = nil
            self.itemTwo.text = nil
            self.priceTwo.text = nil
            
            self.quantityThree.text = nil
            self.itemThree.text = nil
            self.priceThree.text = nil
            
            self.quantityFour.text = nil
            self.itemFour.text = nil
            self.priceFour.text = nil
            
            self.quantityFive.text = nil
            self.itemFive.text = nil
            self.priceFive.text = nil

            self.quantitySix.text = nil
            self.itemSix.text = nil
            self.priceSix.text = nil

            self.quantitySeven.text = nil
            self.itemSeven.text = nil
            self.priceSeven.text = nil
        }
        
        for var i = 0; i < variables.itemCount!.count; i++ {
            self.newTotalItemPrice += (Double(arrItemCount[i]) * arrPrice[i])
            
        }
        variables.totalItemPrice! = self.newTotalItemPrice
        
        self.totalPrice.text = formatter.stringFromNumber(variables.totalItemPrice!)
        
        self.collectionView.reloadData()
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let coCell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        
        self.newTotalItemPrice = 0
        
        self.selectedImage = indexPath.item
        self.detailStepper.value = Double(self.arrItemCount[indexPath.item])
        self.detailQuantity.text = "\(Int(self.detailStepper.value))"
        self.detailTitle.text = variables.itemNames![indexPath.item]
        self.detailImage.image = UIImage(named: "\(arrImages[indexPath.item])")
        self.detailPrice.text = formatter.stringFromNumber(arrPrice[indexPath.item])
        self.detailIngredients.text = "Ingredients: " + variables.itemIngredients![indexPath.item]
        
        
        UIView.animateWithDuration(0.7, animations: { () -> Void in
            self.dimView.alpha = 0.7
            self.detailView.alpha = 1
        })
        
        
        if self.arrItemCount[indexPath.item] != 0 {
            
            coCell.foodQuantity.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            coCell.foodQuantity.text = " x " + "\(Int(arrItemCount[indexPath.item]))"
            coCell.subtractButton.alpha = 0.8
            coCell.subtractButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            
            for var i = 0; i < variables.itemCount!.count; i++ {
                self.newTotalItemPrice += (Double(arrItemCount[i]) * arrPrice[i])
                
            }
            variables.totalItemPrice! = self.newTotalItemPrice
                
            self.totalPrice.text = formatter.stringFromNumber(variables.totalItemPrice!)
            self.doneButton.alpha = 1
            self.doneButton.addTarget(self, action: "donePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        else if variables.totalItemPrice! == 0 {
            self.totalPrice.text = "$0.00"
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: 150, height: 150)
    }
    
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    // Stepper Button
    @IBAction func stepperPressed(sender: UIStepper) {
        
        self.quantityLabel = Int(detailStepper.value)
        variables.totalItemPrice! = Double(self.quantityLabel)
        self.arrItemCount[self.selectedImage] = self.quantityLabel
        self.detailQuantity.text = "\(self.quantityLabel)"
        
        self.collectionView.reloadData()
    
        
    }
    
    // Done Button
    func donePressed(sender: UIButton) {
        
        UIView.animateWithDuration(0.7, animations: { () -> Void in
            self.dimView.alpha = 0.7
            self.receiptView.alpha = 1
        })
        
        // Organize the list
        for var i = 0; i < arrImages.count; i++ {
            if arrItemCount[i] != 0 {
                itemReceipt.append(self.arrImages[i] as! String)
                qtyReceipt.append(self.arrItemCount[i])
                priceReceipt.append(self.arrPrice[i])
            }
            
        }
        
        // Put the order list on the receipt
        for var x = 0; x < qtyReceipt.count; x++ {
            
            if x == 0 && x < qtyReceipt.count {
                self.quantityOne.text = String("\(qtyReceipt[0])")
                self.itemOne.text = itemReceipt[0]
                self.priceOne.text = formatter.stringFromNumber(priceReceipt[0] * Double(qtyReceipt[0]))
            }
            else if x == 1 && x < qtyReceipt.count {
                self.quantityTwo.text = String("\(qtyReceipt[1])")
                self.itemTwo.text = itemReceipt[1]
                self.priceTwo.text = formatter.stringFromNumber(priceReceipt[1] * Double(qtyReceipt[1]))
            }
            else if x == 2 && x < qtyReceipt.count {
                self.quantityThree.text = String("\(qtyReceipt[2])")
                self.itemThree.text = itemReceipt[2]
                self.priceThree.text = formatter.stringFromNumber(priceReceipt[2] * Double(qtyReceipt[2]))
            }
            else if x == 3 && x < qtyReceipt.count {
                self.quantityFour.text = String("\(qtyReceipt[3])")
                self.itemFour.text = itemReceipt[3]
                self.priceFour.text = formatter.stringFromNumber(priceReceipt[3] * Double(qtyReceipt[3]))
            }
            else if x == 4 && x < qtyReceipt.count {
                self.quantityFive.text = String("\(qtyReceipt[4])")
                self.itemFive.text = itemReceipt[4]
                self.priceFive.text = formatter.stringFromNumber(priceReceipt[4] * Double(qtyReceipt[4]))
            }
            else if x == 5 && x < qtyReceipt.count {
                self.quantitySix.text = String("\(qtyReceipt[5])")
                self.itemSix.text = itemReceipt[5]
                self.priceSix.text = formatter.stringFromNumber(priceReceipt[5] * Double(qtyReceipt[5]))
            }
            else if x == 6 && x < qtyReceipt.count {
                self.quantitySeven.text = String("\(qtyReceipt[6])")
                self.itemSeven.text = itemReceipt[6]
                self.priceSeven.text = formatter.stringFromNumber(priceReceipt[6] * Double(qtyReceipt[6]))
            }
            else {
                return
            }
        }
        self.totalDue.text = self.totalPrice.text
    }

    @IBAction func detailViewClose(sender: AnyObject) {
        
        if self.detailBackImage.alpha != 0 {
            UIView.transitionFromView(self.detailBackImage, toView: self.detailImage, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
            
            self.detailBackImage.alpha = 0
            self.detailIngredients.alpha = 0
        }
        
        UIView.animateWithDuration(0.7, animations: { () -> Void in
            self.dimView.alpha = 0
            self.detailView.alpha = 0
        })

    }

    @IBAction func receiptViewClose(sender: AnyObject) {
        
        UIView.animateWithDuration(0.7, animations: { () -> Void in
            self.dimView.alpha = 0
            self.receiptView.alpha = 0
        })
        
        self.itemReceipt = []
        self.qtyReceipt = []
        self.priceReceipt = []
    }

    
    
    
    // TableView  (iPhone 6 plus: set Width to 414, iPhone 6: 375, iPhone 5/5s: 320)
    func tableView(tableView3: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    
    func tableView(tableView3: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Try to get a cell to reuse
        let cell3 = TableView3.dequeueReusableCellWithIdentifier("Tablecell3") as! TableViewCell3
        
        // Make the insets to zero
        cell3.layoutMargins = UIEdgeInsetsZero
        
        // Customize cell
        cell3.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell3.tableViewLabel!.text = self.tableCellList[indexPath.row] as? String
        cell3.tableViewImage.image = UIImage(named: (tableCellImage.objectAtIndex(indexPath.row) as! String) )

        return cell3
    }
    
    func tableView(tableView3: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedRow2 = indexPath.row
        
        if  self.selectedRow2 == 0 {
            self.performSegueWithIdentifier("toFhooderReviewsView", sender: TableView3)
        }
        else if self.selectedRow2 == 1 {
            self.performSegueWithIdentifier("toFhooderPhotosView", sender: TableView3)
        }
        else if self.selectedRow2 == 2 {
            self.performSegueWithIdentifier("toFhooderMessageView", sender: TableView3)
        }
        else if self.selectedRow2 == 3 {
            self.performSegueWithIdentifier("toAboutFhooderView", sender: TableView3)
        }
        
        TableView3.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func completeOrder(sender: AnyObject) {
                
        self.finalView.layer.cornerRadius = 9
        self.finalReminder.text = "Would you like to confirm your order?"
        
        UIView.animateWithDuration(0.7, animations: { () -> Void in
            self.dimView2.alpha = 0.7
            self.finalView.alpha = 1
        })

    }
    
    @IBAction func finalCancel(sender: AnyObject) {
        
        UIView.animateWithDuration(0.7, animations: { () -> Void in
            self.dimView2.alpha = 0
            self.finalView.alpha = 0
        })
        
    }
}
