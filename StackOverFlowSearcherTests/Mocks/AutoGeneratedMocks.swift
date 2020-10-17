// MARK: - Mocks generated from file: StackOverFlowSearcher/Article search/ArticleRepository.swift at 2020-10-15 00:32:29 +0000

//
//  ArticleNetworkController.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/14.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import Cuckoo
@testable import StackOverFlowSearcher

import Foundation


 class MockArticleRepository: ArticleRepository, Cuckoo.ProtocolMock {
    
     typealias MocksType = ArticleRepository
    
     typealias Stubbing = __StubbingProxy_ArticleRepository
     typealias Verification = __VerificationProxy_ArticleRepository

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ArticleRepository?

     func enableDefaultImplementation(_ stub: ArticleRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func fecthArticles(searchTerm: String, pageSize: UInt) throws -> [Question] {
        
    return try cuckoo_manager.callThrows("fecthArticles(searchTerm: String, pageSize: UInt) throws -> [Article]",
            parameters: (searchTerm, pageSize),
            escapingParameters: (searchTerm, pageSize),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.fecthQuestions(searchTerm: searchTerm, pageSize: pageSize))
        
    }
    

	 struct __StubbingProxy_ArticleRepository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func fecthArticles<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(searchTerm: M1, pageSize: M2) -> Cuckoo.ProtocolStubThrowingFunction<(String, UInt), [Article]> where M1.MatchedType == String, M2.MatchedType == UInt {
	        let matchers: [Cuckoo.ParameterMatcher<(String, UInt)>] = [wrap(matchable: searchTerm) { $0.0 }, wrap(matchable: pageSize) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockArticleRepository.self, method: "fecthArticles(searchTerm: String, pageSize: UInt) throws -> [Article]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ArticleRepository: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func fecthArticles<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(searchTerm: M1, pageSize: M2) -> Cuckoo.__DoNotUse<(String, UInt), [Article]> where M1.MatchedType == String, M2.MatchedType == UInt {
	        let matchers: [Cuckoo.ParameterMatcher<(String, UInt)>] = [wrap(matchable: searchTerm) { $0.0 }, wrap(matchable: pageSize) { $0.1 }]
	        return cuckoo_manager.verify("fecthArticles(searchTerm: String, pageSize: UInt) throws -> [Article]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ArticleRepositoryStub: ArticleRepository {
    

    

    
     func fecthArticles(searchTerm: String, pageSize: UInt) throws -> [Question]  {
        return DefaultValueRegistry.defaultValue(for: ([Question]).self)
    }
    
}



 class MockArticleRepositoryImplementation: ArticleRepositoryImplementation, Cuckoo.ClassMock {
    
     typealias MocksType = ArticleRepositoryImplementation
    
     typealias Stubbing = __StubbingProxy_ArticleRepositoryImplementation
     typealias Verification = __VerificationProxy_ArticleRepositoryImplementation

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: ArticleRepositoryImplementation?

     func enableDefaultImplementation(_ stub: ArticleRepositoryImplementation) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func fecthQuestions(searchTerm: String, pageSize: UInt) throws -> [Question] {
        
    return try cuckoo_manager.callThrows("fecthArticles(searchTerm: String, pageSize: UInt) throws -> [Article]",
            parameters: (searchTerm, pageSize),
            escapingParameters: (searchTerm, pageSize),
            superclassCall:
                
                super.fecthQuestions(searchTerm: searchTerm, pageSize: pageSize)
                ,
            defaultCall: __defaultImplStub!.fecthQuestions(searchTerm: searchTerm, pageSize: pageSize))
        
    }
    

	 struct __StubbingProxy_ArticleRepositoryImplementation: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func fecthArticles<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(searchTerm: M1, pageSize: M2) -> Cuckoo.ClassStubThrowingFunction<(String, UInt), [Article]> where M1.MatchedType == String, M2.MatchedType == UInt {
	        let matchers: [Cuckoo.ParameterMatcher<(String, UInt)>] = [wrap(matchable: searchTerm) { $0.0 }, wrap(matchable: pageSize) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockArticleRepositoryImplementation.self, method: "fecthArticles(searchTerm: String, pageSize: UInt) throws -> [Article]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ArticleRepositoryImplementation: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func fecthArticles<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(searchTerm: M1, pageSize: M2) -> Cuckoo.__DoNotUse<(String, UInt), [Article]> where M1.MatchedType == String, M2.MatchedType == UInt {
	        let matchers: [Cuckoo.ParameterMatcher<(String, UInt)>] = [wrap(matchable: searchTerm) { $0.0 }, wrap(matchable: pageSize) { $0.1 }]
	        return cuckoo_manager.verify("fecthArticles(searchTerm: String, pageSize: UInt) throws -> [Article]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ArticleRepositoryImplementationStub: ArticleRepositoryImplementation {
    

    

    
     override func fecthQuestions(searchTerm: String, pageSize: UInt) throws -> [Question]  {
        return DefaultValueRegistry.defaultValue(for: ([Question]).self)
    }
    
}

