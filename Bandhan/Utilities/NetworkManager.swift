//
//  NetworkService.swift
//  Bandhan
//
//  Created by Vivek on 7/14/25.
//

import Foundation
import Combine


class networkManager {
    
    enum networkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "Bad URL Response: \(url)"
            case .unknown:
                return "Unknown Error"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handelURLResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handelURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
        else {
            throw networkingError.badURLResponse(url: url )
        }
        return output.data
    }
    static func handelCompletion(completion: Subscribers.Completion<Error>) {
            switch completion{
            case .finished:
                break
            case .failure(let error):
                print("error:\(error.localizedDescription)")
            }
    }
}
