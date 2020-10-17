//
//  AnswerHeadereTableViewCell.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/17.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import UIKit

class AnswerHeaderTableViewCell: UITableViewCell {
    static let nib = UINib(nibName: "AnswerHeaderTableViewCell", bundle: nil)
    static let reuseIdentifier = "AnswerHeaderTableViewCell"
    typealias Configuration = (HeadingDTO)
    struct HeadingDTO {
        let title: String
        let creationTimeDescription: String
        let answeringTimeDescriptiton: String
        let numberOfViewDescriptiton: String
        let author: String
        let imageURL: String
        let authorReputation: Int64
        let dateDescription: String
        let answerCountDescription: String
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = .init(top: 0, left: .greatestFiniteMagnitude, bottom: 0, right: 0)
    }
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var creationDetailsLabel: UILabel!
    @IBOutlet weak private var answerTimeLabel: UILabel!
    @IBOutlet weak private var viewCountLabeel: UILabel!
    @IBOutlet weak private var answerCountLabel: UILabel!
    @IBOutlet weak private var authorLabel: UILabel!
    @IBOutlet weak private var reputationLabel: UILabel!
    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var dateDescriptionLabel: UILabel!
    
    public func accept(configuration: AnswerHeaderTableViewCell.Configuration) {
        titleLabel.text = configuration.title
        answerCountLabel.text = configuration.answerCountDescription
        creationDetailsLabel.attributedText = makeAtributedContent(prefix: LocalizedCopy(named: "000-Asked"),
                                                                   information: configuration.creationTimeDescription)
        answerTimeLabel.attributedText = makeAtributedContent(prefix: LocalizedCopy(named: "000-Answered"),
                                                              information: configuration.answeringTimeDescriptiton)
        viewCountLabeel.attributedText = makeAtributedContent(prefix: LocalizedCopy(named: "000-Viewed"),
                                                              information: configuration.numberOfViewDescriptiton)
        authorLabel.text = configuration.author
        reputationLabel.text = NumberFormatter().string(from: NSNumber(value: configuration.authorReputation))
        dateDescriptionLabel.attributedText = makeAtributedContent(prefix: LocalizedCopy(named: "000-Asked"),
        information: configuration.dateDescription)
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
