//
//  Article.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/14.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import Foundation

struct QuestionResponse: Codable {
    let items: [Question]
}

struct CreationDetails: Codable {
    let displayName: String
    let profileImage: String
    let reputation: Int64
}

struct Question: Codable, Equatable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        lhs.questionId == rhs.questionId
    }
    
    let questionId: UInt64
    let body: String
    let title: String
    let viewCount: UInt64
    let answerCount: UInt64
    let score: Int64
    let isAnswered: Bool
    let creationDate: Date
    let owner: CreationDetails
    let lastActivityDate: Date
}
