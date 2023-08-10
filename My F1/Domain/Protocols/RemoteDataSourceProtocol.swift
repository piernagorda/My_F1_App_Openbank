//
//  RemoteDataSourceProtocol.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 2/8/23.
//

import Foundation

protocol RemoteDataSourceProtocol{
    func getCircuits(year: String, completion: @escaping (CircuitTable) -> ())
    func getResults(year: String, completion: @escaping (RaceTable) -> ())
    func getCircuitsAPI(year: String) async throws -> CircuitTable?
}
