//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Henry Bao on 5/12/22.
//

import Foundation
import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var choiceBtnOne: UIButton!
    @IBOutlet weak var choiceBtnTwo: UIButton!
    @IBOutlet weak var choiceBtnThree: UIButton!
    @IBOutlet weak var choiceBtnFour: UIButton!
    
    @IBOutlet weak var submitBtn: UIBarButtonItem!

    var choiceBtns: [UIButton] = [UIButton]()
    var questions: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        submitBtn.isEnabled = false
        let question = questions[questionIndex]
        questionLabel.text = question.text
        choiceBtns = [choiceBtnOne, choiceBtnTwo, choiceBtnThree, choiceBtnFour]
        for i in 0..<question.choices.count {
            choiceBtns[i].setTitle(question.choices[i], for: .normal)
        }
    }

    @IBAction func backBtnClick(_ sender: Any) {
        let main = storyboard?.instantiateViewController(withIdentifier: "Main") as! ViewController
        main.modalPresentationStyle = .fullScreen
        self.present(main, animated: true, completion: nil)
        score = 0
        questionIndex = 0
    }
    
    var selected: Int = 0
    
    @IBAction func choiceBtnClick(_ sender: Any) {
        selected = choiceBtns.firstIndex(of: sender as! UIButton)! + 1
        submitBtn.isEnabled = true
        let btn = sender as! UIButton
        for b in choiceBtns {
            if b == btn {
                b.tintColor = UIColor.systemGreen
            } else {
                b.tintColor = UIColor.systemBlue
            }
        }
    }
    
    @IBAction func submitBtnClick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Answer") as! AnswerViewController
        vc.questions = questions
        vc.selected = selected
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
