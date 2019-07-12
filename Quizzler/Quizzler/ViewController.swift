//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    var allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        checkAnswer()
    
        questionNumber = questionNumber + 1
        
        nextQuestion()
    
  
    }
    
    
    func updateUI() {
        progressBar.frame.size.width = (view.frame.size.width) / 13 * CGFloat(questionNumber + 1)
        progressLabel.text = "(\(questionNumber + 1)/13)"
        scoreLabel.text = "Score: \(score)"
        
        
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        }
        else {
            // create alert
            let alertUI = UIAlertController(title: "Excellent!", message: "You won all the questions, do you want to restart?", preferredStyle: .alert)
            alertUI.addAction(UIAlertAction(title: "Restart", style: .default, handler: { action in
                self.startOver()
            }))
            present(alertUI, animated: true, completion: nil)
        }
        }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        if correctAnswer == pickedAnswer {
            ProgressHUD.showSuccess("Correct!")
            score = score + 1
        }
        else {
            ProgressHUD.showError("Wrong!")
            
        }
    }
    
    
    func startOver() {
        questionNumber = 0
        nextQuestion()
        score = 0
        scoreLabel.text = "\(0)"
    
    }
    

    
}
