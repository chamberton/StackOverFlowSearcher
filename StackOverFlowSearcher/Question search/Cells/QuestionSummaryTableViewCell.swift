//
//  QuestionSummaryTableViewCell.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/16.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import UIKit

class QuestionSummaryTableViewCell: UITableViewCell {
    typealias Configuration = (statsDTO: StatsDTO, creationDTO: CreationDTO, contentDTO: ContentDTO, shouldHideIndicator: Bool, isLast: Bool)
    
    struct StatsDTO {
        let answerCountDescription: String
        let voteCountDescription: String
        let viewCountDescription: String
    }
    struct CreationDTO {
        let dateDescription: String
        let author: String
    }
    struct ContentDTO {
        let title: String
        let body: String
    }
    static let nib = UINib(nibName: "QuestionSummaryTableViewCell", bundle: nil)
    static let reuseIdentifier = "QuestionSummaryTableViewCell"
    
    @IBOutlet weak private var statsWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak private var disclosureImageView: UIImageView!
    @IBOutlet weak private var voteCountLabel: UILabel!
    @IBOutlet weak private var answerCountLabel: UILabel!
    @IBOutlet weak private var separtorLabel: UILabel!
    @IBOutlet weak private var viewCountLabel: UILabel!
    @IBOutlet weak private var answeredStatusImageView: UIImageView!
    @IBOutlet weak private var creationDetailsLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        disclosureImageView.image = UIImage(named: "ic-arrow-right")
        separatorInset = .init(top: 0, left: .greatestFiniteMagnitude, bottom: 0, right: 0)
    }
    
    private func setupStatsIndicatorLabels(_ statsDTO: QuestionSummaryTableViewCell.StatsDTO) {
        voteCountLabel.text = statsDTO.voteCountDescription
        viewCountLabel.text = statsDTO.viewCountDescription
        answerCountLabel.text = statsDTO.answerCountDescription
        
        statsWidthConstraint.constant = max(voteCountLabel.intrinsicContentSize.width , viewCountLabel.intrinsicContentSize.width, answerCountLabel.intrinsicContentSize.width)
        setNeedsUpdateConstraints()
    }
    
    public func accept(configuration: Configuration) {
        setupStatsIndicatorLabels(configuration.statsDTO)
        titleLabel.text = configuration.contentDTO.title
        bodyLabel.attributedText = configuration.contentDTO.body.htmlToAttributedString
        let creationDetailsText = NSString(string: configuration.creationDTO.dateDescription + " " + LocalizedCopy(named: "000-By") + " " + configuration.creationDTO.author)
        let attributedCreationDetailsText = NSMutableAttributedString(string: creationDetailsText as String,
                                                                      attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .semibold)])
        
        let authorNameRange = creationDetailsText.range(of: configuration.creationDTO.author)
        attributedCreationDetailsText.setAttributes([.foregroundColor : tintColor as Any,
                                                     .font: UIFont.systemFont(ofSize: 13, weight: .semibold)], range: authorNameRange)
        creationDetailsLabel.attributedText = attributedCreationDetailsText
        disclosureImageView?.isHidden = configuration.shouldHideIndicator
        selectionStyle = configuration.shouldHideIndicator ? .none : .default
        separtorLabel.isHidden = configuration.isLast
    }
}
