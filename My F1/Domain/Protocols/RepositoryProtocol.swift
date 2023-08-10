//
//  RepositoryProtocol.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 2/8/23.
//

import Foundation

protocol RepositoryProtocol{
    func getCircuits(year: String, completion: @escaping (CircuitTable) -> ())
    func getResults(year: String, completion: @escaping (RaceTable) -> ())
}
