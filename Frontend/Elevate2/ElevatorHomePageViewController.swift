//
//  ElevatorHomePageViewController.swift
//  Elevate2
//
//  Created by Elevate App on 10/19/20.
//

import UIKit

class ElevatorHomePageViewController: UIViewController {
    var up = true
    
    @IBOutlet weak var currentFloor: UILabel!
    
    @IBOutlet weak var web: UIWebView!
    
    @IBAction func upButton(_ sender: UIButton) {
        let url=URL(string: "http://18.219.245.250:80/1/up")
        let urlreq=URLRequest(url: url!)
        self.web.loadRequest(urlreq)
        
        up = true
        self.performSegue(withIdentifier: "upPressed", sender: up)
    }
    @IBAction func downButton(_ sender: UIButton) {
        let url=URL(string: "http://18.219.245.250:80/1/down")
        let urlreq=URLRequest(url: url!)
        self.web.loadRequest(urlreq)
        
        up = false
        self.performSegue(withIdentifier: "downPressed", sender: up)
        
    }
    
    
    
    @IBOutlet weak var upButtonOutlet: UIButton!
    
    @IBOutlet weak var downButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 116/255, green: 223/255, blue: 246/255, alpha: 1.0)
        //(red: 116, green: 223, blue: 246, alpha: 1)
        //let upButtons = upButton()
        currentFloor.center = self.currentFloor.center
        
        upButtonOutlet.center.x = self.upButtonOutlet.center.x
        upButtonOutlet.frame.origin.y = 75
        
        downButtonOutlet.center.x = self.downButtonOutlet.center.x
        
        downButtonOutlet.frame.origin.y = 500
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "upPressed") {
            let segueViewController = segue.destination as! CurrentFloorViewController
            segueViewController.up = up
        }
        if (segue.identifier == "downPressed") {
            let segueViewController = segue.destination as! CurrentFloorViewController
            segueViewController.up = up
        }
    }
    


}
