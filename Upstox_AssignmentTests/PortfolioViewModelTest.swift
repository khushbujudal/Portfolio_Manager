//
//  PortfolioViewModel.swift
//  Upstox_AssignmentTests
//
//  Created by Khushbu Judal on 22/11/24.
//
/*
import XCTest
@testable import Upstox_Assignment

final class PortfolioViewModelTests: XCTestCase {
    var viewModel: PortfolioViewModel!
    var mockFetcher: MockNetworkFetcher!

    override func setUp() {
        super.setUp()
        mockFetcher = MockNetworkFetcher()
        viewModel = PortfolioViewModel(networkFetcher: mockFetcher)
    }

    override func tearDown() {
        viewModel = nil
        mockFetcher = nil
        super.tearDown()
    }

    func testFetchPortfolioData_Success() async {
        let data = try! JSONEncoder().encode(UserPortfolio(data: Portfolio(userHolding: [])))
        let response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockFetcher.result = .success((data, response))

        await viewModel.fetchPortfolioData()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.portfolio)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchPortfolioData_Failure_InvalidURL() async {
        mockFetcher.result = .failure(NetworkError.invalidURL)

        await viewModel.fetchPortfolioData()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.portfolio)
        XCTAssertEqual(viewModel.errorMessage, NetworkError.invalidURL.errorMessage)
    }

    func testFetchPortfolioData_Failure_DecodingError() async {
        let data = Data()
        let response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockFetcher.result = .success((data, response))

        await viewModel.fetchPortfolioData()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.portfolio)
        XCTAssertEqual(viewModel.errorMessage, NetworkError.decodingError(NetworkError.unknownError).errorMessage)
    }

    func testFetchPortfolioData_Failure_RequestFailed() async {
        let error = NSError(domain: "", code: -1, userInfo: nil)
        mockFetcher.result = .failure(NetworkError.requestFailed(error))

        await viewModel.fetchPortfolioData()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.portfolio)
        XCTAssertEqual(viewModel.errorMessage, NetworkError.requestFailed(error).errorMessage)
    }
}
*/
