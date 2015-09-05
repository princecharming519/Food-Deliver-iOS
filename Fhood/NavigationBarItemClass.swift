//
//  NavigationBarItemClass.swift
//  Fhood
//
//  Created by YOUNG on 6/3/15.
//  Copyright (c) 2015 YOUNG&YOUM. All rights reserved.
//

import UIKit

class NavigationBarItemClass: UIViewController {

    var searchBars:UISearchBar = UISearchBar()
    var accountIcon = UIImage(named: "Account")
    var filterIcon  = UIImage(named: "Filter 2")

    func loadNavigationItems() {
        
        // Search Bar with no rim
        UISearchBar.appearance().backgroundImage = UIImage.new()
        
        // Search Bar
        var navBarButton = UIBarButtonItem(customView: searchBars)
        self.navigationItem.titleView = navBarButton.customView
        self.searchBars.placeholder = "Sandwich"
        
        // Account Icon
        var leftBarButton = UIBarButtonItem(image: accountIcon, style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        // Filter Icon
        var rightBarButton = UIBarButtonItem(image: filterIcon, style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = rightBarButton

        
    }
    
    
}
