//
//  ChooseFloorViewController.swift
//  Elevate2
//
//  Created by Elevate App on 11/4/20.
//

import UIKit

class ChooseFloorViewController: UIViewController {

    var up:Bool!
    var buttonPicked:Int!
    var floorDestination = 0
    
    
    let buttonX = 150
    let buttonY = 70
    let buttonHeight = 100
    let buttonWidth = 100
    
    
    @IBOutlet weak var floorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 116/255, green: 223/255, blue: 246/255, alpha: 1.0)
        //(red: 116, green: 223, blue: 246, alpha: 1)
        
        //delegate?.floorData(up: Bool, buttonPicked: Int)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(buttonPicked)
        print(up)
        
        createButtons()
        
        floorLabel.font = UIFont.boldSystemFont(ofSize: 26)
        floorLabel.center.x = self.view.center.x
    }
    
    func createButtons(){
        if (up == true){
            if (buttonPicked <= 3){
                let buttonFour = UIButton(type: .system)
                buttonFour.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
                buttonFour.tintColor = .white
                buttonFour.backgroundColor = .gray
                buttonFour.setTitle("4", for: .normal)
                buttonFour.center.x = self.view.center.x
                buttonFour.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
                
                self.view.addSubview(buttonFour)
                
                buttonFour.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
                
                buttonFour.tag = 4
            }
            if (buttonPicked <= 2){
                let buttonThree = UIButton(type: .system)
                buttonThree.frame = CGRect(x: buttonX, y: buttonY + 130, width: buttonWidth, height: buttonHeight)
                buttonThree.tintColor = .white
                buttonThree.backgroundColor = .gray
                buttonThree.setTitle("3", for: .normal)
                buttonThree.center.x = self.view.center.x
                buttonThree.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
                
                self.view.addSubview(buttonThree)
            
                buttonThree.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
                
                buttonThree.tag = 3
            }
            if (buttonPicked <= 1){
                let buttonTwo = UIButton(type: .system)
                buttonTwo.frame = CGRect(x: buttonX, y: buttonY + 260, width: buttonWidth, height: buttonHeight)
                buttonTwo.tintColor = .white
                buttonTwo.backgroundColor = .gray
                buttonTwo.setTitle("2", for: .normal)
                buttonTwo.center.x = self.view.center.x
                buttonTwo.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
                
                self.view.addSubview(buttonTwo)
                
                buttonTwo.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
                
                buttonTwo.tag = 2
            }
            if (buttonPicked == 0){
                let buttonOne = UIButton(type: .system)
                buttonOne.frame = CGRect(x: buttonX, y: buttonY + 390, width: buttonWidth, height: buttonHeight)
                buttonOne.tintColor = .white
                buttonOne.backgroundColor = .gray
                buttonOne.setTitle("1", for: .normal)
                buttonOne.center.x = self.view.center.x
                buttonOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
                
                self.view.addSubview(buttonOne)
                
                buttonOne.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
                
                buttonOne.tag = 1
            }
        } else {
            if (buttonPicked >= 1){
                let buttonG = UIButton(type: .system)
                buttonG.frame = CGRect(x: buttonX, y: buttonY + 390, width: buttonWidth, height: buttonHeight)
                buttonG.tintColor = .white
                buttonG.backgroundColor = .gray
                buttonG.setTitle("G", for: .normal)
                buttonG.center.x = self.view.center.x
                buttonG.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
                
                self.view.addSubview(buttonG)
                
                buttonG.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
                
                buttonG.tag = 0
            }
            if (buttonPicked >= 2){
                let buttonOne = UIButton(type: .system)
                buttonOne.frame = CGRect(x: buttonX, y: buttonY + 260, width: buttonWidth, height: buttonHeight)
                buttonOne.tintColor = .white
                buttonOne.backgroundColor = .gray
                buttonOne.setTitle("1", for: .normal)
                buttonOne.center.x = self.view.center.x
                buttonOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
                
                self.view.addSubview(buttonOne)
                
                buttonOne.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
                
                buttonOne.tag = 1
            }
            if (buttonPicked >= 3){
                let buttonTwo = UIButton(type: .system)
                buttonTwo.frame = CGRect(x: buttonX, y: buttonY + 130, width: buttonWidth, height: buttonHeight)
                buttonTwo.tintColor = .white
                buttonTwo.backgroundColor = .gray
                buttonTwo.setTitle("2", for: .normal)
                buttonTwo.center.x = self.view.center.x
                buttonTwo.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
                
                self.view.addSubview(buttonTwo)
                
                buttonTwo.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
                
                buttonTwo.tag = 2
            }
            if (buttonPicked == 4){
                let buttonThree = UIButton(type: .system)
                buttonThree.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
                buttonThree.tintColor = .white
                buttonThree.backgroundColor = .gray
                buttonThree.setTitle("3", for: .normal)
                buttonThree.center.x = self.view.center.x
                buttonThree.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
                
                self.view.addSubview(buttonThree)
                
                buttonThree.addTarget(self, action: #selector(button_clicked(_:)), for: .touchUpInside)
                
                buttonThree.tag = 3
            }
        }
    }
    
    @IBAction func button_clicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "confirmationSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "confirmationSegue" {
            if let segueViewController = segue.destination as? ChooseFloorViewController {
                let btn:UIButton = sender as! UIButton
                
                print("--")
                print(btn.tag)
                print("--")
                
                if btn.tag == 0{
                    segueViewController.floorDestination = btn.tag
                } else if btn.tag == 1{
                    segueViewController.floorDestination = btn.tag
                } else if btn.tag == 2{
                    segueViewController.floorDestination = btn.tag
                } else if btn.tag == 3{
                    segueViewController.floorDestination = btn.tag
                } else if btn.tag == 4{
                    segueViewController.floorDestination = btn.tag
                }
                
                segueViewController.up = up
                segueViewController.buttonPicked = buttonPicked
            }
        }
     }
    
}
