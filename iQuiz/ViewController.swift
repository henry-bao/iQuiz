//
//  ViewController.swift
//  iQuiz
//
//  Created by Henry Bao on 5/12/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let questionDic = [
        "Mathematics": [
            "image": "math",
            "description": "Let's test your understanding with basic mathematics questions.",
            "questions": []
        ],
        "Marvel Super Heros": [
            "image": "marvel",
            "description": "Are you a real super heros fan? Answer these fun Marvel trivia questions!",
            "questions": []
        ],
        "Science": [
            "image": "science",
            "description": "How much do you know about the body, space, and nature?",
            "questions": []
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
        cell.subject.text = Array(questionDic.keys)[indexPath.row]
        cell.subjectImage.image = UIImage(named: Array(questionDic.values)[indexPath.row]["image"]! as! String)
        cell.subjectDescription.text = Array(questionDic.values)[indexPath.row]["description"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionDic.count
    }

    @IBAction func settingClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

