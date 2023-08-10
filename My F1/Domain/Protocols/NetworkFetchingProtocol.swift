//
//  NetworkFetchingProtocol.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 10/8/23.
//

import Foundation
import Combine


protocol NetworkFetchingProtocol {
    func data(url: URLRequest) async throws  -> (Data, URLResponse)
    func load(fromRequest request: URLRequest) -> AnyPublisher<Data, Error>
}
