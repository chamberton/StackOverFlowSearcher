//
//  Answer.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/16.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import Foundation

struct AnswerResponse: Codable {
    let items: [Answer]
}

struct Answer: Codable {
    let answerId: UInt64
    let creationDate: Date
    let lastActivityDate: Date
    let owner: CreationDetails
    let score: Int
    let body: String
}
