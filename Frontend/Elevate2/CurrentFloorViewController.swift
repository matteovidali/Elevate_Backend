//
//  CurrentFloorViewController.swift
//  Elevate2
//
//  Created by Elevate App on 11/4/20.
//

import UIKit

//protocol FloorDelegate {
//    func floorData(up: Bool, buttonPicked: Int)
//}

class CurrentFloorViewController: UIViewController {
    //pass these variables
    var up:Bool!
    var buttonPicked = 0
    
    
    let buttonX = 150
    let buttonY = 70
    let buttonHeight = 100
    let buttonWidth = 100
    
    @IBOutlet weak var floorLabel: UILabel!
    
    func floorData(up: Bool, buttonPicked: Int) {
        print(up)
        print(buttonPicked)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 116/255, green: 223/255, blue: 246/255, alpha: 1.0)
        //(red: 116, green: 223, blue: 246, alpha: 1)
        print("---")
        print(up)
        print("---")
        createButtons()
        
        floorLabel.font = UIFont.boldSystemFont(ofSize: 26)
        floorLabel.center.x = self.view.center.x
        
        //perform(#selector(advance), with: nil, afterDelay: 0.5)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createButtons(){
        if (up == true) {
            let buttonThree = UIButton(type: .system)
            buttonThree.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
            buttonThree.tintColor = .white
            buttonThree.backgroundColor = .gray
            buttonThree.setTitle("3", for: .normal)
            buttonThree.center.x = self.view.center.x
            buttonThree.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
            
            let buttonTwo = UIButton(type: .system)
            buttonTwo.frame = CGRect(x: buttonX, y: buttonY + 130, width: buttonWidth, height: buttonHeight)
            buttonTwo.tintColor = .white
            buttonTwo.backgroundColor = .gray
            buttonTwo.setTitle("2", for: .normal)
            buttonTwo.center.x = self.view.center.x
            buttonTwo.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
            
            let buttonOne = UIButton(type: .system)
            buttonOne.frame = CGRect(x: buttonX, y: buttonY + 260, width: buttonWidth, height: buttonHeight)
            buttonOne.tintColor = .white
            buttonOne.backgroundColor = .gray
            buttonOne.setTitle("1", for: .normal)
            buttonOne.center.x = self.view.center.x
            buttonOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
            
            let buttonG = UIButton(type: .system)
            buttonG.frame = CGRect(x: buttonX, y: buttonY + 390, width: buttonWidth, height: buttonHeight)
            buttonG.tintColor = .white
            buttonG.backgroundColor = .gray
            buttonG.setTitle("G", for: .normal)
            buttonG.center.x = self.view.center.x
            buttonG.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
            
            self.view.addSubview(buttonThree)
            self.view.addSubview(buttonTwo)
            self.view.addSubview(buttonOne)
            self.view.addSubview(buttonG)
            
            buttonG.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
            buttonOne.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
            buttonTwo.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
            buttonThree.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
            
            buttonG.tag = 0
            buttonOne.tag = 1
            buttonTwo.tag = 2
            buttonThree.tag = 3
        } else {
            let buttonThree = UIButton(type: .system)
            buttonThree.frame = CGRect(x: buttonX, y: buttonY + 130, width: buttonWidth, height: buttonHeight)
            buttonThree.tintColor = .white
            buttonThree.backgroundColor = .gray
            buttonThree.setTitle("3", for: .normal)
            buttonThree.center.x = self.view.center.x
            buttonThree.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
            
            let buttonTwo = UIButton(type: .system)
            buttonTwo.frame = CGRect(x: buttonX, y: buttonY + 260, width: buttonWidth, height: buttonHeight)
            buttonTwo.tintColor = .white
            buttonTwo.backgroundColor = .gray
            buttonTwo.setTitle("2", for: .normal)
            buttonTwo.center.x = self.view.center.x
            buttonTwo.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
            
            let buttonOne = UIButton(type: .system)
            buttonOne.frame = CGRect(x: buttonX, y: buttonY + 390, width: buttonWidth, height: buttonHeight)
            buttonOne.tintColor = .white
            buttonOne.backgroundColor = .gray
            buttonOne.setTitle("1", for: .normal)
            buttonOne.center.x = self.view.center.x
            buttonOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
            
            let buttonFour = UIButton(type: .system)
            buttonFour.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
            buttonFour.tintColor = .white
            buttonFour.backgroundColor = .gray
            buttonFour.setTitle("4", for: .normal)
            buttonFour.center.x = self.view.center.x
            buttonFour.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
            
            self.view.addSubview(buttonThree)
            self.view.addSubview(buttonTwo)
            self.view.addSubview(buttonOne)
            self.view.addSubview(buttonFour)
            
            buttonFour.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
            buttonOne.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
            buttonTwo.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
            buttonThree.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
            
            buttonFour.tag = 4
            buttonOne.tag = 1
            buttonTwo.tag = 2
            buttonThree.tag = 3
            
        }
    }
    
    
    
    @IBAction func button_clicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "chooseFloorSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseFloorSegue" {
            if let segueViewController = segue.destination as? ChooseFloorViewController {
                let btn:UIButton = sender as! UIButton
                
                print("--")
                print(btn.tag)
                print("--")
                
                if btn.tag == 0{
                    segueViewController.buttonPicked = btn.tag
                } else if btn.tag == 1{
                    segueViewController.buttonPicked = btn.tag
                } else if btn.tag == 2{
                    segueViewController.buttonPicked = btn.tag
                } else if btn.tag == 3{
                    segueViewController.buttonPicked = btn.tag
                } else if btn.tag == 4{
                    segueViewController.buttonPicked = btn.tag
                }
                
                segueViewController.up = up
            }
        }
     }
    
    
//    @objc func advance(){
//        let vc = ChooseFloorViewController()
//        vc.delegate = self
//        vc.buttonPicked = buttonPicked
//        vc.up = up
//        present(ChooseFloorViewController(), animated: true, completion: nil)
//    }

}
