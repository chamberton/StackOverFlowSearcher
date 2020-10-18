//
//  AnswerTableViewCell.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/17.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    typealias Configuration = AnswerDetails
    struct AnswerDetails {
        let voteDescription: String
        let body: String
        let author: String
        let dateDescription: String
        let imageURL: String
        let authorRepuation: Int64
    }
    @IBOutlet weak private var bodyTextView: UITextView!
    @IBOutlet weak private var voteLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var authorLabel: UILabel!
    @IBOutlet weak private var reputationLabel: UILabel!
    @IBOutlet weak private var profileImageView: UIImageView!
    
    static let nib = UINib(nibName: "AnswerTableViewCell", bundle: nil)
    static let reuseIdentifier = "AnswerTableViewCell"
    
    
    func accept(configuration: Configuration) {
        voteLabel.text = configuration.voteDescription
        bodyTextView.attributedText = configuration.body.htmlToAttributedString
        dateLabel.attributedText = makeAtributedContent(prefix: LocalizedCopy(named: "000-Answered"),
                                                        information: configuration.dateDescription)
        authorLabel.text = configuration.author
        reputationLabel.text = NumberFormatter().string(from: NSNumber(value: configuration.authorRepuation))
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let imageURL = URL(string: configuration.imageURL),
                let imageData = try? Data.init(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self?.profileImageView.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    func makeAtributedContent(prefix: String, information: String) -> NSAttributedString {
        let creationDetailsText = NSString(string: prefix + " " + information)
        let attributedCreationDetailsText = NSMutableAttributedString(string: creationDetailsText as String,
                                                                      attributes: [.foregroundColor : UIColor.gray as Any,
                                                                                   .font: UIFont.systemFont(ofSize: 10, weight: .medium)])
        
        let authorNameRange = creationDetailsText.range(of: information)
        attributedCreationDetailsText.setAttributes([.foregroundColor : UIColor.black as Any,
                                                     .font: UIFont.systemFont(ofSize: 10, weight: .semibold)], range: authorNameRange)
        
        return attributedCreationDetailsText
    }
    
}
