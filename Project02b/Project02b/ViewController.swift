//
//  ViewController.swift
//  Project02b
//
//  Created by Ione Souza Junior on 01/10/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButtonBorder()
        game = Game(options: ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"])
        let options = game.start()
        showQuestion(options: options)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
    }
    
    @objc func showScore() {
        let viewController = UIAlertController(title: "Game score", message: "Your score is \(game.score).", preferredStyle: .alert)
        viewController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(viewController, animated: true)
    }
    
    func addButtonBorder() {
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func showQuestion(options: (option1: String, option2: String, option3: String)) {
        button1.setImage(UIImage(named: options.option1), for: .normal)
        button2.setImage(UIImage(named: options.option2), for: .normal)
        button3.setImage(UIImage(named: options.option3), for: .normal)
        title = "\(game.getOptionNameBy(id: game.correctAnswer)) - Score: \(game.score)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        
        var title: String
        var message = ""
        
        if game.answer(sender.tag) {
            title = "Correct"
        } else {
            title = "Wrong"
            message += "That's the flag of \(game.getOptionNameBy(id: sender.tag)).\n"
        }
        
        message += "Your score is \(game.score)."
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default) {
            [weak self] _ in
            self?.checkForTheNextQuestion()
        })
        present(alert, animated: true)
    }
    
    func checkForTheNextQuestion() {
        if game.isOver() {
            let highestScoreKey = "highest_score"
            let defaults = UserDefaults.standard
            let highestScore = defaults.integer(forKey: highestScoreKey)
            var message = "Your final score is \(game.score)."
            
            if game.score > highestScore {
                defaults.set(game.score, forKey: highestScoreKey)
                message += "\n\nCongratulations! Your score beat the previous high!"
            }
            
            let alert = UIAlertController(title: "Game over", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: restart))
            present(alert, animated: true)
        } else {
            let options = game.nextQuestion()
            showQuestion(options: options)
        }
    }
    
    func restart(action: UIAlertAction) {
        let options = game.start()
        showQuestion(options: options)
    }
}

