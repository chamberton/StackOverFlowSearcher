//
//  ArticleNetworkController.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/14.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import Foundation

protocol ArticleRepository {
    func fecthQuestions(searchTerm: String, pageSize: UInt) throws -> [Question]
    func fetchAnswersForQuestionIdentified(by questionId: UInt64) throws -> [Answer]
}

class ArticleRepositoryImplementation: ArticleRepository {
    private lazy var httpGetClient = resolve(HTTPGetClient.self)
    private let defaultQueryParameters : HTTPDictionary = ["order":"desc",
                                                           "sort":"activity",
                                                           "site":"stackoverflow",
                                                           "filter":"withbody"]
    
    func fecthQuestions(searchTerm: String, pageSize: UInt) throws -> [Question] {
        var queryParameters = defaultQueryParameters
        queryParameters["pagesize"] = pageSize
        queryParameters["title"] = searchTerm
        guard let operatitonResult = httpGetClient?.get(from: .stackOverFlow,
                                                        urlBuildable: StakOverflowHTTPPath.searchItem,
                                                        queryParameters: queryParameters,
                                                        pathParameters: [],
                                                        additionalHeaders: ["Accept": "Appliction/json"],
                                                        timeoutInterval: Double.defaultTimeout) else {
                                                            throw HTTPError.unknown
        }
        
        switch operatitonResult {
        case .failure(let encounteredError):
            throw encounteredError
        case .success(let fetchedData):
            guard let questions: QuestionResponse = decode(from: fetchedData) else {
                throw HTTPError.badData
            }
            return questions.items
        }
    }
    
    func fetchAnswersForQuestionIdentified(by questionId: UInt64) throws -> [Answer] {
        
        guard let operatitonResult = httpGetClient?.get(from: .stackOverFlow,
                                                        urlBuildable: StakOverflowHTTPPath.itemDetails,
                                                        queryParameters: defaultQueryParameters,
                                                        pathParameters: [questionId.description, "answers"],
                                                        additionalHeaders: ["Accept": "Appliction/json"],
                                                        timeoutInterval: Double.defaultTimeout) else {
                                                            throw HTTPError.unknown
        }
        
        switch operatitonResult {
        case .failure(let encounteredError):
            throw encounteredError
        case .success(let fetchedData):
            guard let articles: AnswerResponse = decode(from: fetchedData) else {
                throw HTTPError.badData
            }
            return articles.items
        }
    }
}
