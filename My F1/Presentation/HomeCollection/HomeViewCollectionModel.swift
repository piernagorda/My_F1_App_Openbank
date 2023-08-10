//
//  HomeTableViewModel.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 2/8/23.
//

import UIKit

final class HomeViewCollectionModel{
    
    private let repository: RepositoryProtocol //
    private let homeViewController: HomeViewCollectionController
    var arrayOfCircuits: [CircuitFull] = []
    var arrayOfResults: RaceTable?
    private var year: String = "2020"
    
    init(repository: RepositoryProtocol, homeViewController: HomeViewCollectionController) {
        self.repository = repository
        self.homeViewController = homeViewController
        self.getCircuits(year: self.year){
            DispatchQueue.main.async {
                homeViewController.collectionView.reloadData()
                print("Initial circuits load. \(self.arrayOfCircuits.count)")
            }
        }
        self.getResults(year: year){
            DispatchQueue.main.async {
                //homeViewController.collectionView.reloadData()
                
                for x in self.arrayOfResults!.races{
                    print(x.raceName)
                }
            }
        }
        
    }
    
    //Desde aqui llamamos al repositorio para que coja los datos. Si no hay error se pasan arriba
    private func getCircuits(year: String, completion: @escaping ()->()){
        
        self.repository.getCircuits(year: year){ circuits in
            for x in circuits.circuits{
                let image = UIImage(named: getAlpha2(country: x.location.country).lowercased()) ?? UIImage(named: "default-image")
                let structure: CircuitFull = CircuitFull(circuitInfo: x, countryImage: image)
                self.arrayOfCircuits.append(structure)
            }
            completion()
        }
    }
    
    private func getResults(year: String, completion: @escaping ()->()){
        self.repository.getResults(year: year){ results in
            self.arrayOfResults = results
            completion()
        }
    }
    
    //Metodo que se llama cuando se cambia el año
    func changeYear(newYear: String){
        self.year = newYear
        self.arrayOfCircuits = []
        self.getCircuits(year: self.year){
            DispatchQueue.main.async {
                self.homeViewController.collectionView.reloadData()
                print("Season reloaded. Count: \(self.arrayOfCircuits.count)")
            }
        }
        self.getResults(year: self.year){
            DispatchQueue.main.async {
                print("Season Results Reloaded")
            }
        }
    }
    
    func getYear() -> String { return self.year }
    
}
