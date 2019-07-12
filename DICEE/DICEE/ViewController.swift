//
//  ViewController.swift
//  DICEE
//
//  Created by Anhi on 5/25/19.
//  Copyright © 2019 ANNA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    var randomDiceIndex1: Int = 0
    var randomDiceIndex2: Int = 0

    
    
    
    @IBOutlet weak var DiceImageView1: UIImageView!
    @IBOutlet weak var DiceImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDiceImages()
    }
    
    
    @IBAction func RollButtonPressed(_ sender: UIButton) {
        
        updateDiceImages()
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
    
    func updateDiceImages() {
        
        randomDiceIndex1 = Int.random(in: 0 ... 5)
        randomDiceIndex2 = Int.random(in: 0 ... 5)
        
        
        DiceImageView1.image = UIImage (named: diceArray[randomDiceIndex1])
        DiceImageView2.image = UIImage (named: diceArray[randomDiceIndex2])
    }

    

    
    
    
}

