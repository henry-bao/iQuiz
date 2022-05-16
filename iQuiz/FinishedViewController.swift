//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Henry Bao on 5/12/22.
//

import Foundation
import UIKit

class FinishedViewController: UIViewController {
    
    var questions: [Question] = []
    @IBOutlet weak var statsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        statsLabel.text = "You got \(score) questions out of \(questions.count) right!"
    }
    
    @IBAction func nextBtnClick(_ sender: Any) {
        let main = storyboard?.instantiateViewController(withIdentifier: "Main") as! ViewController
        main.modalPresentationStyle = .fullScreen
        self.present(main, animated: true, completion: nil)
        score = 0
        questionIndex = 0
    }
}
