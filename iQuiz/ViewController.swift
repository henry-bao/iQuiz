//
//  ViewController.swift
//  iQuiz
//
//  Created by Henry Bao on 5/12/22.
//

import UIKit

var score: Int = 0
var questionIndex: Int = 0

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let questionDict = [
        "Mathematics": [
            "image": "math",
            "description": "Let's test your understanding with basic mathematics questions.",
            "questions": [
                Question(text: "20 = 3x + 8; x = ?", answer:3,
                         choices: ["3", "2", "4","5",]),
                Question(text: "If y = 3x + 12 and y = 5, what is x?", answer: 4,
                         choices: ["7/3", "3/7", "-7","-7/3",])
            ]
        ],
        "Marvel Super Heros": [
            "image": "marvel",
            "description": "Are you a real super heros fan? Answer these fun Marvel trivia questions!",
            "questions": [
                Question(text: "Who is the actor for Dr.Strange", answer: 1,
                         choices: ["Benedict Cumberbatch", "Chiwetel Ejiofor", "Michael Stuhlbarg", "Benedict Wong"]
                ),
                Question(text: "During which war did Captain America get his superhuman abilities?", answer: 3,
                         choices: ["Civil War", "World War I", "World War II", "The Cold War"]
                )
            ]
        ],
        "Science": [
            "image": "science",
            "description": "How much do you know about the body, space, and nature?",
            "questions": [
                Question(text: "At what temperature Celsius and Fahrenheit equal?", answer: 2,
                         choices: ["-32", "-40", "0","-38",]),
                Question(text: "What is the lrgest internal organ of the human body?", answer: 1,
                         choices: ["Liver", "Lung", "Pancreas","Heart",])
            ]
        ],
    ]
    
    
    @IBOutlet weak var subjectTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        subjectTable.delegate = self
        subjectTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SubjectTableCell = subjectTable.dequeueReusableCell(withIdentifier: "Subject Cell") as! SubjectTableCell
        cell.subject.text = Array(questionDict.keys)[indexPath.row]
        cell.subjectImage.image = UIImage(named: Array(questionDict.values)[indexPath.row]["image"]! as! String)
        cell.subjectDescription.text = Array(questionDict.values)[indexPath.row]["description"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionDict.count
    }

    @IBAction func settingClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Question") as! QuestionViewController
        let subject = Array(questionDict.keys)[indexPath.row]
        let questions = (questionDict[subject]!["questions"] as! [Question])
        vc.questions = questions
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
