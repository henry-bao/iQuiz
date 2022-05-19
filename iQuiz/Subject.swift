//
//  Subject.swift
//  iQuiz
//
//  Created by Henry Bao on 5/18/22.
//

import Foundation

class Subject {
    
    var subject: String
    var description: String
    var questions: [Question]

    init(subject: String, description: String, questions: [Question]) {
        self.subject = subject
        self.description = description
        self.questions = questions
    }
}

let defaultSubjectDict: [Subject] = [
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
                description: "Did you pass the third grade?",
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
