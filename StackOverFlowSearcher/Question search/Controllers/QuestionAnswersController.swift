//
//  QuestionAnswersController.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/12.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import Foundation
import DateToolsSwift

class QuestionAnswersController {
    private(set) var answers = [Answer]()
    private lazy var articleRepository = resolve(ArticleRepository.self)
    let question: Question
    
    var headerConfiguration: AnswerHeaderTableViewCell.Configuration {
        var answerCountDescription = "\(answers.count) \(LocalizedCopy(named: "000-Answer"))"
        if answers.count > 1 {
            answerCountDescription += LocalizedCopy(named: "000-Plural")
        }
        let numberOfViewDescriptiton = "\(question.viewCount) \(LocalizedCopy(named: "000-Times"))"
        return AnswerHeaderTableViewCell.Configuration(title: question.title,
                                                       creationTimeDescription: question.creationDate.timeAgoSinceNow,
                                                       answeringTimeDescriptiton: question.lastActivityDate.timeAgoSinceNow,
                                                       numberOfViewDescriptiton: numberOfViewDescriptiton,
                                                       author: question.owner.displayName,
                                                       imageURL: question.owner.profileImage,
                                                       authorReputation: question.owner.reputation,
                                                       dateDescription: question.creationDate.friendlyFullYearDescription,
                                                       answerCountDescription: answerCountDescription)
    }
    
    init(question: Question) {
        self.question = question
    }
    
    func fetchAnswers(questionsHandler: @escaping ([AnswerTableViewCell.Configuration]) -> (Void),
                      errorHandler: @escaping (ErrorInfo) -> (Void)) {
        answers.removeAll()
        do {
            if let answers = try articleRepository?.fetchAnswersForQuestionIdentified(by: question.questionId) {
                self.answers = answers.sorted()
                questionsHandler(makeViewDetailsForCurrentAnswers(answers: self.answers))
            } else {
                errorHandler((LocalizedCopy(named: "000-Error"), LocalizedCopy(named: "000-Error-Occured")))
            }
        } catch let error as HTTPError {
            errorHandler((error.titleForRenderedError, error.messageForRenderedError))
        } catch {
            errorHandler((LocalizedCopy(named: "000-Error"), LocalizedCopy(named: "000-Error-Occured")))
        }
    }
    
    
    private func makeViewDetailsForCurrentAnswers(answers: [Answer]) -> [AnswerTableViewCell.Configuration] {
        return answers.map { (answer) -> AnswerTableViewCell.Configuration in
            var voteDescription =  "\(answer.score) \n \(LocalizedCopy(named: "000-Vote"))"
            if answer.score > 1 {
                voteDescription += LocalizedCopy(named: "000-Plural")
            }
            return AnswerTableViewCell.Configuration(voteDescription: voteDescription,
                                                     body: answer.body,
                                                     author: answer.owner.displayName,
                                                     dateDescription: answer.creationDate.friendlyFullYearDescription,
                                                     imageURL: answer.owner.profileImage,
                                                     authorRepuation: answer.owner.reputation)
        }
    }
    
    public func sortedAnswers() -> [AnswerTableViewCell.Configuration] {
          return makeViewDetailsForCurrentAnswers(answers: answers.sorted())
      }
}
