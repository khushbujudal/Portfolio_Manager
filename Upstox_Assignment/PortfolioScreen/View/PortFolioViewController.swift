//
//  PortfolioViewController.swift
//  Upstox_Assignment
//
//  Created by Khushbu Judal on 19/11/24.
//

import UIKit
import Combine

class PortfolioViewController: UIViewController {
    
    // MARK: - UI Elements
    private let tableView = UITableView()
    
    private let currentValueLabel = UILabel()
    private let totalInvestmentLabel = UILabel()
    private let todaysPnLLabel = UILabel()
    private let totalPnLLabel = UILabel()
    
    var holdings: [Holding] = []
    var portfolioSummary: Portfolio?
    let viewModel = PortfolioViewModel(networkFetcher: NetworkManager.shared)
    private var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    private let summaryView = SummaryView()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.PortfolioView.title
        view.backgroundColor = .white
        
        setupTableView()
        setupSummaryView()
        setupBindings()
        loadPortfolio()
    }
    
    // MARK: - Table View Setup
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HoldingCell.self, forCellReuseIdentifier: Constants.HoldingCell.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -60)
        ])
    }
    
    private func setupSummaryView() {
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(summaryView)
        
        NSLayoutConstraint.activate([
            summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            summaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.handleLoadingState(isLoading: isLoading)
            }
            .store(in: &cancellables)
        
        viewModel.$portfolio
            .receive(on: DispatchQueue.main)
            .sink { [weak self] portfolio in
                if let portfolio = portfolio {
                    self?.handlePortfolioData(portfolio: portfolio)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.handleError(message: errorMessage)
            }
            .store(in: &cancellables)
    }
    
    //API call from view model
    private func loadPortfolio() {
        Task {
            viewModel.isLoading = true
            await viewModel.fetchPortfolioData()
        }
    }
    
    private func handleLoadingState(isLoading: Bool) {
        self.isLoading = isLoading
        self.tableView.reloadData()
    }
    
    private func handlePortfolioData(portfolio: Portfolio) {
        self.holdings = portfolio.userHolding ?? []
        self.portfolioSummary = portfolio
        self.summaryView.updateSummary(portfolio: portfolio)
        self.tableView.reloadData()
    }
    
    private func handleError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

extension PortfolioViewController : UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table View DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoading ? 10 : holdings.count  // Return a mock number of rows for shimmer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.HoldingCell.cellIdentifier, for: indexPath) as? HoldingCell else {
            return UITableViewCell()
        }
        if !isLoading {
            let holding = holdings.count > indexPath.row ? holdings[indexPath.row] : nil
            cell.configure(with: holding)
        }
        return cell
    }
}
