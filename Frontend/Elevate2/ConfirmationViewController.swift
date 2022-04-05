//
//  ConfirmationViewController.swift
//  Elevate2
//
//  Created by Elevate App on 11/4/20.
//

import UIKit

class ConfirmationViewController: UIViewController {
    
    var up:Bool!
    var buttonPicked:Int!
    var floorDestination:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 116/255, green: 223/255, blue: 246/255, alpha: 1.0)
        //(red: 116, green: 223, blue: 246, alpha: 1)
        print("-Done-")
        print(up)
        print(buttonPicked)
        print(floorDestination)
        print("-Done-")
    }
    

}
