//
//  NetworkManager.swift
//  Upstox_Assignment
//
//  Created by Khushbu Judal on 20/11/24.
//

import Foundation

protocol NetworkFetching {
    func fetchData<T: Decodable>(urlString: String, decodingType: T.Type) async -> Result<T, NetworkError>
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case noData
    case decodingError(Error)
    case unknownError
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return Constants.errorMessages.invalidURL
        case .requestFailed(let error):
            return Constants.errorMessages.requestFailed + error.localizedDescription
        case .noData:
            return Constants.errorMessages.noData
        case .decodingError(let error):
            return Constants.errorMessages.decodingError + error.localizedDescription
        case .unknownError:
            return Constants.errorMessages.unknownError
        }
    }
}

class NetworkManager: NetworkFetching {
    
    static let shared = NetworkManager()
    private init() {}
    
    /// Generic function to fetch data
    /// - Parameters:
    ///   - urlString: The API endpoint as a string
    ///   - decodingType: The type of the object to decode
    ///   - completion: A result type callback with success or failure
    func fetchData<T: Decodable>(urlString: String, decodingType: T.Type) async -> Result<T, NetworkError> {
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let responseData = try? JSONDecoder().decode(T.self, from: data) else {
                return .failure(.decodingError(NetworkError.unknownError))
            }
            return .success(responseData)
        } catch let error {
            if let decodingError = error as? DecodingError {
                return .failure(.decodingError(decodingError))
            }
            return .failure(.requestFailed(error))
        }
    }
}


