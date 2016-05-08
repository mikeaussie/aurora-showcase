//
//  MaterialView.swift
//  aurora-showcase
//
//  Created by Mike Piatin on 8/05/2016.
//  Copyright © 2016 Aurora Software. All rights reserved.
//

import UIKit

class MaterialView: UIView {

    override func awakeFromNib() {
        
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0 //a blur radius
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        //CGSizeMake width is set for 0.0, and the shadow is set by the bigger blur radius
        //height is set for 2.0, meaning that it will stick from the one side
        
    }
    
    
    
    


}
