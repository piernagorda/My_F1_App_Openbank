//
//  URLProtocolMock.swift
//  My F1Tests
//
//  Created by Piernagorda Olive Javier on 10/8/23.
//

import Foundation

final class URLProtocolMock: URLProtocol {
    
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse,Data?))?
    
    //Verify if the protocol can perform the request
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    //Convert the request to a canonical request
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func stopLoading() {
    }
    
    override func startLoading() {
        guard let handler = URLProtocolMock.requestHandler else {
            fatalError("Handler must be initialized to inject the url protocol mock")
        }
        do{
            let(response,data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .allowed)
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        }catch{
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
}
