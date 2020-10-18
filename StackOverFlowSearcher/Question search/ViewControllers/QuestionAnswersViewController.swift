//
//  ArticleDetailsViewController.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/12.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import UIKit

class QuestionAnswersViewController: UITableViewController {
    let questionAnswersController:  QuestionAnswersController
    private var answerConfigurations = [AnswerTableViewCell.Configuration]()
    
    init(question: Question) {
        self.questionAnswersController = QuestionAnswersController(question: question)
        super.init(style: .plain)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureTableView()
        loadAnswers()
    }
    
    private func setup() {
        title =  LocalizedCopy(named: "000-More-info")
        navigationController?.navigationBar.tintColor = .darkText
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(AnswerHeaderTableViewCell.nib, forCellReuseIdentifier: AnswerHeaderTableViewCell.reuseIdentifier)
        tableView.register(AnswerTableViewCell.nib, forCellReuseIdentifier: AnswerTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.allowsSelection = false
        tableView.reloadData()
    }
}

extension QuestionAnswersViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: AnswerHeaderTableViewCell.reuseIdentifier, for: indexPath) as? AnswerHeaderTableViewCell else {
                return UITableViewCell()
            }
            headerCell.accept(configuration: questionAnswersController.headerConfiguration)
            headerCell.sortingDelegate = self
            return headerCell
        }
        guard let answerCell = tableView.dequeueReusableCell(withIdentifier: AnswerTableViewCell.reuseIdentifier, for: indexPath) as? AnswerTableViewCell else {
            return UITableViewCell()
        }
        answerCell.accept(configuration: answerConfigurations[indexPath.row - 1])
        return answerCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answerConfigurations.isEmpty ? 0 : answerConfigurations.count + 1
    }
    
    func loadAnswers() {
        DispatchQueue.main.async { [unowned self] in
            self.showLoadingIndicator(LocalizedCopy(named: "000-Loading"))
            
            DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
                self.questionAnswersController.fetchAnswers(questionsHandler: { [weak self] answers -> (Void) in
                    DispatchQueue.main.async { self?.setupView(answerConfigurations: answers) }
                    },
                                                            errorHandler: { [weak self] (error) -> (Void) in
                                                                DispatchQueue.main.async { self?.showError(error) }
                })
            }
        }
    }
    
    func setupView(answerConfigurations: [AnswerTableViewCell.Configuration]) {
        self.answerConfigurations = answerConfigurations
        hideLoadingIndicator()
        tableView.reloadData()
    }
    
    func showError( _ errorInfo: ErrorInfo) {
        hideLoadingIndicator()
        showFailureAlert(title: errorInfo.errorTitle,
                         message: errorInfo.errorMessage) { [unowned self] in
                            self.loadAnswers()
        }
    }
}


extension QuestionAnswersViewController: AnswerSorter {
    func sortingView(_ view: AnswerHeaderTableViewCell, didRequestSortingBasedOn sortingCriteria: Answer.SortingCriteria) {
        defer { tableView.isScrollEnabled = true }
        DispatchQueue.main.async {
            self.showLoadingIndicator("000-Sorting")
        }
        tableView.isScrollEnabled = false
        Answer.sortingCriteria = sortingCriteria
        answerConfigurations =  questionAnswersController.sortedAnswers()
        let updatableIndexPaths = answerConfigurations.indices.map { (index) -> IndexPath in
            IndexPath(row: index + 1, section: 0)
        }
        
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadRows(at: updatableIndexPaths, with: .fade)
            self.hideLoadingIndicator()
        }
    }
}
