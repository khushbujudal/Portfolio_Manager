//
//  PortfolioViewModel.swift
//  Upstox_Assignment
//
//  Created by Khushbu Judal on 19/11/24.
//

import Foundation

class PortfolioViewModel: ObservableObject {
    
    @Published var portfolio: Portfolio?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkFetcher: NetworkFetching
    
    init(networkFetcher: NetworkFetching) {
        self.networkFetcher = networkFetcher
    }
    
    func fetchPortfolioData() async {
        let urlString = APIEndPoints.portfolioAPI
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        let result: Result<UserPortfolio, NetworkError> = await networkFetcher.fetchData(urlString: urlString, decodingType: UserPortfolio.self)
        
        switch result {
        case .success(let userPortfolio):
            DispatchQueue.main.async {
                self.isLoading = false
                self.portfolio = userPortfolio.data
                self.errorMessage = nil
            }
        case .failure(let error):
            DispatchQueue.main.async {
                self.isLoading = false
                self.portfolio = nil
                self.errorMessage = error.errorMessage
            }
        }
    }
}

