//
//  ViewController.swift
//  Project02
//
//  Created by Ione Souza Junior on 01/10/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var answeredQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        addButtonBorder()
        askQuestion()
    }
    
    func addButtonBorder() {
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = "\(countries[correctAnswer].uppercased()) - Score: \(score)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        answeredQuestions += 1
        let alert = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: checkForTheNextQuestion))
        present(alert, animated: true)
    }
    
    func checkForTheNextQuestion(action: UIAlertAction! = nil) {
        if answeredQuestions == 10 {
            let alert = UIAlertController(title: "Game over", message: "Your final score is \(score).", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: restart))
            present(alert, animated: true)
        } else {
            askQuestion()
        }
    }
    
    func restart(action: UIAlertAction! = nil) {
        answeredQuestions = 0
        score = 0
        askQuestion()
    }
}

