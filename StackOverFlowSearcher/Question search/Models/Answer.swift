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

struct Answer: Codable, Comparable {
    enum SortingCriteria: CaseIterable {
        case creartionDate
        case lastActivityDatte
        case score
        
        var title: String {
            switch self {
            case .creartionDate:
                return LocalizedCopy(named: "000-Oldest")
            case .score:
                return LocalizedCopy(named: "000-Vote").capitalized +  LocalizedCopy(named: "000-Plural")
            case .lastActivityDatte:
                 return LocalizedCopy(named: "000-Active")
            }
        }
    }
    static var sortingCriteria: SortingCriteria = .score
    let answerId: UInt64
    let creationDate: Date
    let lastActivityDate: Date
    let owner: CreationDetails
    let score: Int
    let body: String
    
    static func ==(lhs: Answer, rhs: Answer) -> Bool {
        switch sortingCriteria {
        case .creartionDate:
            return lhs.creationDate == rhs.creationDate
        case .score:
            return lhs.score == rhs.score
        case .lastActivityDatte:
            return lhs.score == rhs.score
        }
    }
    
    static func <(lhs: Answer, rhs: Answer) -> Bool {
        switch sortingCriteria {
        case .creartionDate:
            return lhs.creationDate > rhs.creationDate
        case .score:
            return lhs.score > rhs.score
        case .lastActivityDatte:
            return lhs.lastActivityDate > rhs.lastActivityDate
        }
    }
    
}
