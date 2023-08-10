//
//  RepositoryImplementation.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 2/8/23.
//

import Foundation

class RepositoryImplementation: RepositoryProtocol{
    
    
    
    var dataSource: RemoteDataSourceProtocol?
    
    init(dataSource: RemoteDataSourceImplementation?) {
        self.dataSource = dataSource
    }
    
    func getCircuits(year: String, completion: @escaping (CircuitTable) -> ()) {
        dataSource?.getCircuits(year: year, completion: completion)
    }
    
    func getResults(year: String, completion: @escaping (RaceTable) -> ()) {
        dataSource?.getResults(year: year, completion: completion)
    }
    
    
}
