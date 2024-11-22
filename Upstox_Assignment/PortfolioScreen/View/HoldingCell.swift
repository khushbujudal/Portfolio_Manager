//
//  StockTableViewCell.swift
//  Upstox_Assignment
//
//  Created by Khushbu Judal on 19/11/24.
//

import UIKit

class HoldingCell: UITableViewCell {
    
    // MARK: - UI Elements
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.isHidden = true
        return label
    }()
    
    private let qtyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.isHidden = true
        return label
    }()
    
    private let ltpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .right
        label.isHidden = true
        return label
    }()
    
    private let pnlLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.textAlignment = .right
        label.isHidden = true
        return label
    }()
    
    // Placeholder views for shimmer
    private let namePlaceholder = ShimmerLoaderView()
    private let pnlPlaceholder = ShimmerLoaderView()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Cell
    func configure(with holding: Holding?) {
        if let holding = holding {
            // Hide shimmer and show actual data labels
            namePlaceholder.isHidden = true
            namePlaceholder.stopShimmerAnimation()
            pnlPlaceholder.isHidden = true
            pnlPlaceholder.stopShimmerAnimation()
            
            nameLabel.isHidden = false
            qtyLabel.isHidden = false
            ltpLabel.isHidden = false
            pnlLabel.isHidden = false
            
            // Set actual data
            nameLabel.text = holding.symbol
            qtyLabel.text = Constants.HoldingCell.qtyLabel + "\(holding.quantity)"
            ltpLabel.text = Constants.HoldingCell.ltpLabel + "\(holding.ltp)"
            
            // Calculate P&L
            let pnl = (holding.ltp - holding.avgPrice) * Double(holding.quantity)
            pnlLabel.text = Constants.HoldingCell.pnlLabel + String(format: "%.2f", pnl)
            pnlLabel.textColor = pnl >= 0 ? .systemGreen : .systemRed
            
        } else {
            // Show shimmer placeholders and hide data labels
            namePlaceholder.isHidden = false
            namePlaceholder.startShimmerAnimation()
            pnlPlaceholder.isHidden = false
            pnlPlaceholder.startShimmerAnimation()
            
            nameLabel.isHidden = true
            qtyLabel.isHidden = true
            ltpLabel.isHidden = true
            pnlLabel.isHidden = true
        }
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        // Add labels
        contentView.addSubview(nameLabel)
        contentView.addSubview(qtyLabel)
        contentView.addSubview(ltpLabel)
        contentView.addSubview(pnlLabel)
        
        // Add shimmer placeholder views
        contentView.addSubview(namePlaceholder)
        contentView.addSubview(pnlPlaceholder)
        
        // Apply layout constraints for labels and placeholders
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        qtyLabel.translatesAutoresizingMaskIntoConstraints = false
        ltpLabel.translatesAutoresizingMaskIntoConstraints = false
        pnlLabel.translatesAutoresizingMaskIntoConstraints = false
        
        namePlaceholder.translatesAutoresizingMaskIntoConstraints = false
        pnlPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Name Label and Placeholder
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            namePlaceholder.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            namePlaceholder.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            namePlaceholder.widthAnchor.constraint(equalToConstant: 150),
            namePlaceholder.heightAnchor.constraint(equalToConstant: 20),
            
            // Qty Label and Placeholder
            qtyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            qtyLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            // LTP Label and Placeholder
            ltpLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            ltpLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // PNL Label and Placeholder
            pnlLabel.topAnchor.constraint(equalTo: ltpLabel.bottomAnchor, constant: 4),
            pnlLabel.trailingAnchor.constraint(equalTo: ltpLabel.trailingAnchor),
            
            pnlPlaceholder.topAnchor.constraint(equalTo: pnlLabel.topAnchor),
            pnlPlaceholder.trailingAnchor.constraint(equalTo: pnlLabel.trailingAnchor),
            pnlPlaceholder.widthAnchor.constraint(equalToConstant: 120),
            pnlPlaceholder.heightAnchor.constraint(equalToConstant: 20),
            
            // Bottom Padding
            pnlPlaceholder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
