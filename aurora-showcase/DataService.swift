//
//  DataService.swift
//  aurora-showcase
//
//  Created by Mike Piatin on 11/05/2016.
//  Copyright © 2016 Aurora Software. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "https://aurora-showcase.firebaseio.com")
    //copy the https url from the browser
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    
    
    
}
