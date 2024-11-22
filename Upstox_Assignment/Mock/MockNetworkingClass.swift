//
//  MockNetworkingClass.swift
//  Upstox_Assignment
//
//  Created by Khushbu Judal on 22/11/24.
//

import Foundation

class MockNetworkFetcher: NetworkFetching {
    
    var result: Result<(Data, URLResponse), Error>?
    
    func fetchData<T: Decodable>(urlString: String, decodingType: T.Type) async -> Result<T, NetworkError> {
        if let result = result {
            switch result {
            case .success(let dataResponse):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: dataResponse.0)
                    return .success(decodedData)
                } catch let decodingError {
                    return .failure(.decodingError(decodingError))
                }
            case .failure(let error):
                return .failure(.requestFailed(error))
            }
        }
        return .failure(.unknownError)
    }
}
