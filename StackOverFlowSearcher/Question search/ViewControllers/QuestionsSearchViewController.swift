//
//  ArticlesSearchViewController.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/12.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import UIKit

class QuestionsSearchViewController: UIViewController {
    @IBOutlet private weak var articleTermSearchBar: UISearchBar!
    @IBOutlet weak var emptyStateView: UIView!
    @IBOutlet weak var questionsTableView: UITableView!
    @IBOutlet weak var emptyMessageLabel: UILabel!
    private let articlesController = QuestionsSearchController(maximumResultCount: 40)
    private var questionCellsConfigurations = [(config: QuestionSummaryTableViewCell.Configuration, id: UInt64)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureTableView()
    }
    
    private func setup() {
        setupEmptyStateView()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         setupNavigationBar()
    }
    
    private func configureTableView() {
        questionsTableView.register(QuestionSummaryTableViewCell.nib, forCellReuseIdentifier: QuestionSummaryTableViewCell.reuseIdentifier)
        questionsTableView.rowHeight =  UITableView.automaticDimension
        questionsTableView.separatorInset = .zero
        questionsTableView.tableFooterView = UIView()
    }
    
    @objc func didTapMenuBaraButton(sender: UIBarButtonItem) {
        log("TODO: - Not implemented")
    }
}

extension QuestionsSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        questionCellsConfigurations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let questionCell = tableView.dequeueReusableCell(withIdentifier: QuestionSummaryTableViewCell.reuseIdentifier, for: indexPath) as? QuestionSummaryTableViewCell else {
            return UITableViewCell()
        }
        questionCell.accept(configuration: questionCellsConfigurations[indexPath.row].config)
        return questionCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let question = articlesController.questions[indexPath.row]
        guard !questionCellsConfigurations[indexPath.row].config.shouldHideIndicator else {
            return
        }
        let answersViewController = QuestionAnswersViewController(question: question)
        navigationController?.pushViewController(answersViewController, animated: true)
    }
}

// MARK: - View Setup
private extension QuestionsSearchViewController {
    func setupEmptyStateView() {
        emptyStateView.isHidden = false
        emptyMessageLabel.text = LocalizedCopy(named: "001-Empty-questions-message")
    }
    
    func setupSearchBar() {
        articleTermSearchBar.delegate = self
        articleTermSearchBar.searchTextField.backgroundColor = .whiteControlColor
        articleTermSearchBar.isTranslucent = false
        articleTermSearchBar.barTintColor = .primaryControlBackgroundColor
        articleTermSearchBar.backgroundColor = .primaryControlBackgroundColor
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .whiteControlColor
        navigationController?.navigationBar.tintColor = .whiteControlColor
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:  UIImage(named: "ic-menu")?.withTintColor(.black),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapMenuBaraButton(sender:)))
    }
}

extension QuestionsSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
         emptyMessageLabel.text = LocalizedCopy(named: "001-Empty-questions-message")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, searchTerm.isEmpty==false else {
            setupEmptyStateView()
            return
        }
        DispatchQueue.main.async { [unowned self] in
            self.emptyMessageLabel.text = nil
            self.emptyStateView.isHidden = false
            self.showLoadingIndicator(LocalizedCopy(named: "000-Searching"))
            searchBar.endEditing(true)
            
            DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
                self.articlesController.searchArticles(containing: searchTerm,
                                                       questionsHandler: { [weak self] (questions) -> (Void) in
                                                        DispatchQueue.main.async {
                                                            self?.setupView(questions: questions)
                                                        }
                                                        
                    }, errorHandler: { [weak self] (error) -> (Void) in
                        DispatchQueue.main.async {
                            self?.showError(error)
                        }
                })
            }
        }
        
    }
}

extension QuestionsSearchViewController {
    func setupView(questions: [(QuestionSummaryTableViewCell.Configuration, UInt64)]) {
        hideLoadingIndicator()
        defer { emptyStateView.isHidden = !questions.isEmpty }
        guard !questions.isEmpty else {
            emptyMessageLabel.text = LocalizedCopy(named: "001-No-questions")
            return
        }
        questionCellsConfigurations = questions
        questionsTableView.reloadData()
    }
    
    func showError( _ errorInfo: ErrorInfo) {
        hideLoadingIndicator()
        emptyMessageLabel.text = LocalizedCopy(named: "001-Empty-questions-message")
        showFailureAlert(title: errorInfo.errorTitle, message: errorInfo.errorMessage) { [unowned self] in
            self.searchBarSearchButtonClicked(self.articleTermSearchBar)
        }
    }
}
