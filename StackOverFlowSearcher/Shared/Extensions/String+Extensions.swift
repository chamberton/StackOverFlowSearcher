//
//  String+Extensions.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/16.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        return try? NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding:String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
    }
   
}
