//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Henry Bao on 5/12/22.
//

import Foundation
import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    var questions: [Question] = []
    var selected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let question = questions[questionIndex]
        resultLabel.text = "You got the question \(selected == question.answer ? "right" : "wrong")!"
        answerLabel.text = "The correct answer was \(question.choices[question.answer - 1])"
        resultLabel.textColor = selected == question.answer ? UIColor.systemGreen : UIColor.systemRed
        if selected == question.answer {
            score += 1
        }
    }
    
    @IBAction func backBtnClick(_ sender: Any) {
        let main = storyboard?.instantiateViewController(withIdentifier: "Main") as! ViewController
        main.modalPresentationStyle = .fullScreen
        self.present(main, animated: true, completion: nil)
        score = 0
        questionIndex = 0
    }
    
    @IBAction func nextBtnClick(_ sender: Any) {
        if questionIndex + 1 == questions.count {
            let vc = storyboard?.instantiateViewController(withIdentifier: "Finished") as! FinishedViewController
            vc.questions = questions
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } else {
            questionIndex += 1
            let vc = storyboard?.instantiateViewController(withIdentifier: "Question") as! QuestionViewController
            vc.questions = questions
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
