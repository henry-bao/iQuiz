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
