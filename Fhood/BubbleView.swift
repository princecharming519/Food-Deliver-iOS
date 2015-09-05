//
//  BubbleView.swift
//  CustomPin
//
//  Created by MIKALAI BUSLAYEU on 8/13/15.
//  Copyright (c) 2015 MI. All rights reserved.
//

import UIKit
import MapKit



class BubbleView: MKAnnotationView {

    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ImageLabel: UIImageView!
    @IBOutlet weak var TypeLabel: UILabel!
    @IBOutlet weak var SpoonLabel: UIImageView!
    @IBOutlet weak var ReviewLabel: UILabel!
    @IBOutlet weak var PickupLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var OpenLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    var annotationObj: AnnotationObject?

   
    func SetUpView(annotation: AnnotationObject)
    {
        ReviewLabel.text = annotation.reviewsDescription
        TypeLabel.text = annotation.subtitle
        NameLabel.text = annotation.title
        ImageLabel.image = annotation.image
        
        PriceLabel.text = "$\(annotation.price.description)"
        SpoonLabel.image = annotation.imageRatingActive
        
        backView.layer.cornerRadius = 10

    }
   
        
}
