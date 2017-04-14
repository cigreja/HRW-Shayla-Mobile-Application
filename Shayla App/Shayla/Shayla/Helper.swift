//
//  Helper.swift
//  Shayla
//
//  Created by Mayur Tolani on 02/04/17.
//  Copyright © 2017 HRW Music Group LLC. All rights reserved.
//

import Foundation
import UIKit

class Helper
{
    static let helperObject = Helper()
    
    func switchToNavigationVC() {
        //let strangers log in
        //switch to the navigation view by settin it as the root view controller
        
        //1.create a storybord instance.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //2.create a new navigation view conroller instance
        let naviVC = storyboard.instantiateViewController(withIdentifier: "NavigationVC") as! UINavigationController
        
        //3. get the handle on App delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //4.set the navigation view Controller as root VC
        appDelegate.window?.rootViewController = naviVC
    }

}
