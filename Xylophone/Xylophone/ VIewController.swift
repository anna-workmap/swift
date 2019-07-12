//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    
    var player = AVAudioPlayer()
    var arraySound = ["note1", "note2", "note3", "note4", "note5", "note6", "note7"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func notePressed(_ sender: UIButton) {
        print(playTone(number: arraySound[sender.tag - 1]))
    }
    
        func playTone(number: String) {
            let soundURL = Bundle.main.url(forResource: number, withExtension: "wav")
            do {
                player = try AVAudioPlayer(contentsOf: soundURL!)
            }
            catch {
                print (error)
            }
            player.play()
        }
        

}
