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
    
    let getQuestionUrl = UserDefaults.standard.string(forKey: "question_url") ?? "https://tednewardsandbox.site44.com/questions.json"
    
    var defaultSubjectDict: [Subject] = [
            Subject(subject: "Science!",
                    description: "Because SCIENCE!",
                    questions: [
                        Question(text: "What is fire?",
                                answer: "1",
                                choices: [
                                    "One of the four classical elements",
                                    "A magical reaction given to us by God",
                                    "A band that hasn't yet been discovered",
                                    "Fire! Fire! Fire! heh-heh"
                                    ]
                                )
                    ]
            ),
            Subject(subject: "Marvel Super Heroes",
                    description: "Avengers, Assemble!",
                    questions: [
                        Question(text: "Who is Iron Man?",
                                 answer: "1",
                                 choices: [
                                    "Tony Stark",
                                    "Obadiah Stane",
                                    "A rock hit by Megadeth",
                                    "Nobody knows"
                                    ]
                        ),
                        Question(text: "Who founded the X-Men?",
                                 answer: "2",
                                 choices: [
                                        "Tony Stark",
                                        "Professor X",
                                        "The X-Institute",
                                        "Erik Lensherr"
                                        ]
                        ),
                        Question(text: "How did Spider-Man get his powers?",
                                 answer: "1",
                                 choices:[
                                    "He was bitten by a radioactive spider",
                                    "He ate a radioactive spider",
                                    "He is a radioactive spider",
                                    "He looked at a radioactive spider"
                                    ]
                        )
                    ]
            ),
            Subject(subject: "Mathematics",
                    description: "How much do you know about the body, space, and nature?",
                    questions: [
                        Question(text: "What is 2+2?",
                                answer: "1",
                                choices: [
                                    "4",
                                    "22",
                                    "An irrational number",
                                    "Nobody knows"
                                    ]
                        )
                    ]
            )
    ]

    var subjectDict: [Subject] = []

    @IBOutlet weak var subjectTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        subjectTable.delegate = self
        subjectTable.dataSource = self
        if UserDefaults.standard.string(forKey: "question_url") == nil {
            UserDefaults.standard.set(getQuestionUrl, forKey: "question_url")
        }
        buildQuestions()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SubjectTableCell = subjectTable.dequeueReusableCell(withIdentifier: "Subject Cell") as! SubjectTableCell
        cell.subject.text = subjectDict[indexPath.row].subject
        cell.subjectImage.image = UIImage(named: subjectDict[indexPath.row].subject) ?? UIImage(named: "Placeholder")
        cell.subjectDescription.text = subjectDict[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectDict.count
    }

    @IBAction func settingClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Enter Question URL", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "URL"
            if let url = UserDefaults.standard.string(forKey: "question_url") {
                textField.text = url
            }
        }
        alert.addAction(UIAlertAction(title: "Check Now", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            if textField?.text == "" {
                return
            }
            guard (URL(string: (textField?.text)!) != nil) else {
                let alert = UIAlertController(title: "Error", message: "Invalid URL", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            UserDefaults.standard.set(textField?.text, forKey: "question_url")
            self.fetchAndSaveQuestions((textField?.text)!)
            self.buildQuestions()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Question") as! QuestionViewController
        vc.questions = subjectDict[indexPath.row].questions
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    func fetchAndSaveQuestions(_ url: String) {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if response == nil {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "No response received", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
            if response != nil {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode != 200 {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Error", message: "Connection error: \(httpResponse.statusCode)", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        return
                    }
                }
            }
            if error != nil {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "An error has occurred while fetching data", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        let archiveURL = documentsDirectory.appendingPathComponent("questions.json")
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: JSONSerialization.WritingOptions.prettyPrinted)
                        try jsonData.write(to: archiveURL)
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Success", message: "Questions saved successfully", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Error", message: "The URL is invalid", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        task.resume()
    }

    func buildQuestions() {
        var newSubjectDict: [Subject] = []
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("questions.json")
        let jsonData = try? Data(contentsOf: archiveURL)
        if jsonData == nil {
            newSubjectDict = defaultSubjectDict
        } else {
            let jsonResult = try? JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
            if let jsonResult = jsonResult {
                for i in 0..<jsonResult.count {
                    let subject = Subject(subject: (jsonResult[i] as AnyObject)["title"] as! String,
                                          description: (jsonResult[i] as AnyObject)["desc"] as! String,
                                          questions: [])
                    for j in 0..<((jsonResult[i] as AnyObject)["questions"] as! Array<Any>).count {
                        let question = Question(text: (((jsonResult[i] as AnyObject)["questions"] as AnyObject)[j] as AnyObject)["text"] as! String,
                                                 answer: (((jsonResult[i] as AnyObject)["questions"] as AnyObject)[j] as AnyObject)["answer"] as! String,
                                                 choices: (((jsonResult[i] as AnyObject)["questions"] as AnyObject)[j] as AnyObject)["answers"] as! [String])
                        subject.questions.append(question)
                    }
                    newSubjectDict.append(subject)
                }
            }
        }
        subjectDict = newSubjectDict
        self.subjectTable.reloadData()
    }
}
