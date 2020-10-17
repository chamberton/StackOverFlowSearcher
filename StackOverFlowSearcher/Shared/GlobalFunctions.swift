//
//  GlobalFunctions.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/12.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import UIKit

// MARK: - Localised copy find

func LocalizedCopy(named copyName: String) -> String {
    guard copyName.isEmpty == false, copyName.count > 3 else  { return "" }
    return NSLocalizedString(copyName,
                             tableName: CopyTable(rawValue: String(copyName.prefix(3)))?.tableName,
                             bundle: .main,
                             value: "",
                             comment: "")
}

fileprivate enum CopyTable: String {
    case general = "000", articles = "001"

    var tableName: String {
        switch self {
        case .articles:
          return "Questions"
        case .general:
            return "General"
        }
    }
}

// MARK: - Module classes loading

func objc_getClassList() -> [AnyClass] {
      let expectedClassCount = ObjectiveC.objc_getClassList(nil, Int32(0))
      let allClasses = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(expectedClassCount))
      let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(allClasses)
      let actualClassCount:Int32 = ObjectiveC.objc_getClassList(autoreleasingAllClasses, Int32(expectedClassCount))
      
      var classes = [AnyClass]()
      for i in 0 ..< actualClassCount {
          if let currentClass: AnyClass = allClasses[Int(i)] {
              classes.append(currentClass)
          }
      }
      allClasses.deallocate()
      return classes
  }

// MARK: - Decode class from raw data

func decode<T:Codable>(from rawData: Data) -> T? {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    jsonDecoder.dateDecodingStrategy = .secondsSince1970
    guard let object = try? jsonDecoder.decode(T.self, from: rawData) else {
        return nil
    }
    return object
}
