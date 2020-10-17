//
//  ArticlesController.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/12.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import Foundation

class QuestionsSearchController {
    private(set) var questions = [Question]()
    private lazy var articleRepository = resolve(ArticleRepository.self)
    let maximumResultCount: UInt
    
    init(maximumResultCount: UInt) {
        self.maximumResultCount = maximumResultCount
    }
    
    func searchArticles(containing searchTerm: String,
                        questionsHandler: @escaping ([(QuestionSummaryTableViewCell.Configuration, UInt64)]) -> (Void),
                        errorHandler: @escaping (ErrorInfo) -> (Void)) {
        questions.removeAll()
        do {
            if let articles = try articleRepository?.fecthQuestions(searchTerm: searchTerm, pageSize: maximumResultCount) {
                self.questions = articles
                questionsHandler(makeViewDetailsForCurrentQuestions())
            } else {
                errorHandler((LocalizedCopy(named: "000-Error"), LocalizedCopy(named: "000-Error-Occured")))
            }
        } catch let error as HTTPError {
            errorHandler((error.titleForRenderedError, error.messageForRenderedError))
        } catch {
            errorHandler((LocalizedCopy(named: "000-Error"), LocalizedCopy(named: "000-Error-Occured")))
        }
    }
    
    private func makeViewDetailsForCurrentQuestions() -> [(QuestionSummaryTableViewCell.Configuration, UInt64)] {
        let lastQuestion = questions.last
        return questions.map { (question) -> (QuestionSummaryTableViewCell.Configuration, UInt64) in
            let votesDescription = self.makeCountableDescription(itemTerm: LocalizedCopy(named: "001-Vote"),
                                                                 itmeCount: question.score)
            let answersDescription = self.makeCountableDescription(itemTerm: LocalizedCopy(named: "001-Answer"),
                                                                   itmeCount: Int64(question.answerCount))
            let viewsDescription = self.makeCountableDescription(itemTerm: LocalizedCopy(named: "001-View"),
                                                                 itmeCount: Int64(question.viewCount))
              
            let statsDTO = QuestionSummaryTableViewCell.StatsDTO(answerCountDescription: answersDescription,
                                                                 voteCountDescription: votesDescription,
                                                                 viewCountDescription: viewsDescription)
            let creationDTO = QuestionSummaryTableViewCell.CreationDTO(dateDescription: "\(LocalizedCopy(named: "001-Answer"))  \(question.creationDate.friendlyDescription)",
                                                                    author: question.owner.displayName)
            let contentDTO = QuestionSummaryTableViewCell.ContentDTO(title: "Q: " + question.title, body: question.body)
          
            return ((statsDTO, creationDTO, contentDTO, question.answerCount <= 0, question == lastQuestion), question.questionId)
        }
    }
    
    private func makeCountableDescription(itemTerm: String, itmeCount: Int64) -> String {
         return itmeCount > 0 ? itmeCount > 1 ? "\(itmeCount) \(itemTerm)\(LocalizedCopy(named: "000-Plural"))" : "\(itmeCount) \(itemTerm)":  ""
    }
}
