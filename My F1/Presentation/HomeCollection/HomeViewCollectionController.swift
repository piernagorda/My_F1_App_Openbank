//
//  HomeViewCollectionControllerCollectionViewController.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 8/8/23.
//

import UIKit

class HomeViewCollectionController: UICollectionViewController {
    
    var homeViewModel: HomeViewCollectionModel?
    
    override func viewDidLoad() {
        setViewModel()
        navigationController?.navigationBar.prefersLargeTitles = true
        let nib = UINib(nibName: "HomeCellCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "datacell")
        collectionView.delegate = self
        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        super.viewDidLoad()
    }
    
    private func setViewModel() {
        //Desde el HomeTableViewModel es desde donde creamos el repositorio (al que le pasamos ya el data source)
        let remoteDataSource = RemoteDataSourceImplementation(session: URLSession.shared)
        let repository = RepositoryImplementation(dataSource: remoteDataSource)
        self.homeViewModel = HomeViewCollectionModel(repository: repository, homeViewController: self)
    }

    //Cuando desde Settings se cambia el año, esta es la funcion que se llama
    func changeYear(year: String){
        self.homeViewModel?.changeYear(newYear: year)
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return homeViewModel?.arrayOfCircuits.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "datacell", for: indexPath) as? HomeCellCollectionViewCell else{
            let cell = UICollectionViewCell()
            //var title = UILabel(frame: CGRectMake(0, 0, cell.bounds.size.width, 40))
            //cell.contentView.addSubview(title)
            return cell
        }
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10.0
        cell.layer.masksToBounds = true
        cell.CircuitName?.text = homeViewModel?.arrayOfCircuits[indexPath.row].circuitInfo?.circuitName
        cell.Country?.text = homeViewModel?.arrayOfCircuits[indexPath.row].circuitInfo?.location.country
        cell.CountryFlag?.image = homeViewModel?.arrayOfCircuits[indexPath.row].countryImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nombreCircuito = homeViewModel?.arrayOfCircuits[indexPath.row].circuitInfo?.circuitName
        let pais = homeViewModel?.arrayOfCircuits[indexPath.row].circuitInfo?.location.country
        let imagen = homeViewModel?.arrayOfCircuits[indexPath.row].countryImage
        
        var cardInfoView = CardInformationTableViewController()
        cardInfoView.results = homeViewModel?.arrayOfResults
        cardInfoView.setUpFirstCellData(image: imagen!,
                                        countryName: pais!,
                                        circuitName: nombreCircuito!,
                                        year: homeViewModel!.getYear(),
                                        location: homeViewModel!.arrayOfCircuits[indexPath.row].circuitInfo!.location)
        
        navigationController?.pushViewController(cardInfoView, animated: true)
        //collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
