//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var score: UILabel!
    
    // Properties
    var questionBank = QuestionBank()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        updateUI()
        
    }
    
    @IBAction func answerPressed(_ sender: AnyObject) {
        
        let questionNumber = questionBank.questionNumber
        let userAnswer = sender.tag ?? -1
        let userGotItRight = questionBank.checkAnswer(userAnswer)
        
        // Check to see if current question number exceeds the total number of questions in the question bank
        if questionNumber + 1 < questionBank.questionBank.count {
            // Check to see if user answer was correct
            if userGotItRight {
                // User answer was correct
                ProgressHUD.showSuccess("Correct")
                print("Question #\(questionNumber). Correct!")
            } else {
                // User answer was wrong
                ProgressHUD.showError("Wrong")
                print("Question #\(questionNumber). Wrong!")
            }
            
            questionBank.nextQuestion()
            updateUI()
        } else {
            // Restart quiz when user reaches final question in question bank
            print("End of Quiz!")
            let alert = UIAlertController(title: "Awesome!", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (_) in
                self.questionBank.startOver()
                self.updateUI()
            }
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc func updateUI() {
        
        questionLabel.text = questionBank.getQuestionText()
        progressBar.progress = questionBank.getProgress()
        score.text = "Score: \(questionBank.getScore())"
        
    }
    
}
