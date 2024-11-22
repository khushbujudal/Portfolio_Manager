//
//  PortfolioSummaryView.swift
//  Upstox_Assignment
//
//  Created by Khushbu Judal on 20/11/24.
//

import Foundation
import UIKit

class SummaryView: UIView {
    
    private let profitLossLabel = UILabel()
    private let toggleButton = UIButton(type: .system)
    private let separatorLine = UIView()
    private let stackView = UIStackView()
    private var heightConstraint: NSLayoutConstraint!

    private var isExpanded: Bool = false {
        didSet {
            separatorLine.isHidden = !isExpanded
            toggleButton.setTitle(isExpanded ? "▲" : "▼", for: .normal)
            heightConstraint.constant = isExpanded ? Constants.SummaryView.expandedHeight : Constants.SummaryView.collapsedHeight
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
    
    // Labels for the stack view
    private let currentValueLabel = UILabel()
    private let totalInvestmentLabel = UILabel()
    private let todaysPnlLabel = UILabel()
    private let totalPnlLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Initial setup
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray6
        
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        // container for padding
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            container.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        ])
        
        // Configure stack view
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: container.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        // Add footer with toggle button
        let footerStack = UIStackView()
        footerStack.axis = .horizontal
        footerStack.alignment = .center
        footerStack.distribution = .fill
        footerStack.spacing = 8
        footerStack.translatesAutoresizingMaskIntoConstraints = false

        // stack for the left side: Profit & Loss and the toggle button
        let leftStack = UIStackView()
        leftStack.axis = .horizontal
        leftStack.alignment = .center
        footerStack.distribution = .equalSpacing
        leftStack.spacing = 4
        leftStack.translatesAutoresizingMaskIntoConstraints = false

        // Setup the Profit & Loss label
        profitLossLabel.text = Constants.SummaryView.profitLoss
        profitLossLabel.font = .boldSystemFont(ofSize: 16)
        profitLossLabel.setContentHuggingPriority(.required, for: .horizontal)

        // Setup the toggle button
        toggleButton.setTitle("▼", for: .normal)
        toggleButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        toggleButton.addTarget(self, action: #selector(toggleDetails), for: .touchUpInside)
        toggleButton.setContentHuggingPriority(.required, for: .horizontal)

        leftStack.addArrangedSubview(profitLossLabel)
        leftStack.addArrangedSubview(toggleButton)

        // Setup the Total PNL label
        totalPnlLabel.text = "_"
        totalPnlLabel.font = .boldSystemFont(ofSize: 16)
        totalPnlLabel.textAlignment = .right
        totalPnlLabel.setContentHuggingPriority(.required, for: .horizontal)

        footerStack.addArrangedSubview(leftStack)
        footerStack.addArrangedSubview(totalPnlLabel)
        
        // Add detail rows
        addDetailRow(title: Constants.SummaryView.currentValue, valueLabel: currentValueLabel)
        addDetailRow(title: Constants.SummaryView.totalInvestment, valueLabel: totalInvestmentLabel)
        addDetailRow(title: Constants.SummaryView.todaysPNL, valueLabel: todaysPnlLabel)
        
        // Separator Line
        separatorLine.backgroundColor = .lightGray
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        stackView.addArrangedSubview(separatorLine)
        stackView.addArrangedSubview(footerStack)

        setDetailsHidden(true)
        separatorLine.isHidden = true
        
        heightConstraint = self.heightAnchor.constraint(equalToConstant: Constants.SummaryView.collapsedHeight)
        heightConstraint.isActive = true
    }
    
    // MARK: - Add details row for expanded view
    private func addDetailRow(title: String, valueLabel: UILabel) {
        let rowStack = UIStackView()
        rowStack.axis = .horizontal
        rowStack.alignment = .center
        rowStack.distribution = .fillProportionally
        rowStack.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .darkGray
        
        valueLabel.font = .systemFont(ofSize: 14, weight: .medium)
        valueLabel.textAlignment = .right
        valueLabel.textColor = .black
        
        rowStack.addArrangedSubview(titleLabel)
        rowStack.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(rowStack)
    }
    
    @objc private func toggleDetails() {
        isExpanded.toggle()
        setDetailsHidden(!isExpanded)
    }
    
    // MARK: - Hide/Show the details view on expand/collaps
    private func setDetailsHidden(_ hidden: Bool) {
        for index in 0..<stackView.arrangedSubviews.count - 2{
            stackView.arrangedSubviews[index].isHidden = hidden
        }
    }
    
    // MARK: - Update Data
    func updateSummary(portfolio : Portfolio) {
        currentValueLabel.text = "₹\(portfolio.currentValue.rounded(toPlaces: 2))"
        totalInvestmentLabel.text = "₹\(portfolio.totalInvestment.rounded(toPlaces: 2))"
        todaysPnlLabel.textColor = portfolio.todaysPnL >= 0 ? .systemGreen : .systemRed
        todaysPnlLabel.text = portfolio.todaysPnL >= 0 ? "₹\(portfolio.todaysPnL.rounded(toPlaces: 2))" : "- ₹\(abs(portfolio.todaysPnL.rounded(toPlaces: 2)))"
        totalPnlLabel.text = portfolio.totalPnL >= 0 ? "₹\(portfolio.totalPnL.rounded(toPlaces: 2))" : "- ₹\(abs(portfolio.totalPnL.rounded(toPlaces: 2)))"
        totalPnlLabel.textColor = portfolio.totalPnL >= 0 ? .systemGreen : .systemRed
    }
}
