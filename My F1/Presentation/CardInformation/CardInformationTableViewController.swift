//
//  CardInformationTableViewController.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 9/8/23.
//

import UIKit

class CardInformationTableViewController: UITableViewController {
    
    private var mapViewController: MapViewController?
    private var countryImage: UIImage?
    private var countryName: String?
    private var circuitName: String?
    private var year: String?
    private var location: Location?
    var results: RaceTable?
    
    override func viewDidLoad() {
        //Registramos el NIB de la vista de celda (CardInformationTableView)
        tableView.register(UINib(nibName: "FirstCellViewController", bundle: nil), forCellReuseIdentifier: "datacell1")
        tableView.register(UINib(nibName: "SecondCellsController", bundle: nil), forCellReuseIdentifier: "datacell2")
        tableView.delegate = self
        tableView.separatorStyle = .none
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section==0){
            return 1
        }
        else{
            return self.results!.races[0].results.count
        }
    }

    //Configuracion del tamaño de celda de cada seccion
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section==0){
            return CGFloat(80.0)
        }
        else{
            return CGFloat(44.0)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Para la celda de la primera seccion
        if (indexPath.section==0){
            return firstSectionCell(indexPath: indexPath)
        }
        else{
            //Para todas las que no son la primera celda
            if (indexPath.row != 0){
                return driverCell(indexPath: indexPath)
            }
            //Para la primera celda
            else{
                return returnHeaderCell(indexPath: indexPath)
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section != 0){
            //Para todas las que no son la primera celda
            if (indexPath.row != 0){
                let urlString = self.results?.races[0].results[indexPath.row-1].driver.url
                if let url = URL(string: urlString!) {
                    UIApplication.shared.open(url)
                    tableView.deselectRow(at: indexPath, animated: true)
                }
                else{
                    print("Error opening driver information")
                }
            }
        }
        else{
            self.mapViewController = MapViewController(location: self.location!,
                                                       circuitName: self.circuitName!,
                                                       country: self.countryName!)
            navigationController?.pushViewController(mapViewController!, animated: true)
        }
    }
    
    func setUpFirstCellData(image: UIImage, countryName: String, circuitName: String, year: String, location: Location){
        self.countryImage = image
        self.countryName = countryName
        self.circuitName = circuitName
        self.year = year
        self.location = location
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    
    // MARK: - Configuracion de las celdas
    
    private func firstSectionCell(indexPath: IndexPath) -> FirstCellViewController{
        let cell = (tableView.dequeueReusableCell(withIdentifier: "datacell1", for: indexPath) as? FirstCellViewController)!
        cell.countryImage?.image = self.countryImage
        cell.countryName?.text = self.countryName
        cell.circuitName?.text = self.circuitName
        cell.year?.text = self.year
        cell.layer.cornerRadius = 10.0
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.masksToBounds = true
        return cell
    }
    
    private func returnHeaderCell(indexPath: IndexPath) -> SecondCellsController{
        let cell = tableView.dequeueReusableCell(withIdentifier: "datacell2", for: indexPath) as? SecondCellsController
        cell!.position?.text = "Pos"
        cell?.position?.font = UIFont.boldSystemFont(ofSize: 14.0)
        cell!.famName?.text = "Name"
        cell?.famName?.font = UIFont.boldSystemFont(ofSize: 14.0)
        cell!.team?.text = "Team"
        cell?.team?.font = UIFont.boldSystemFont(ofSize: 14.0)
        cell!.points?.text = "Points"
        cell?.points?.font = UIFont.boldSystemFont(ofSize: 14.0)
        return cell!
    }
    
    private func driverCell(indexPath: IndexPath) -> SecondCellsController{
        let cell = tableView.dequeueReusableCell(withIdentifier: "datacell2", for: indexPath) as? SecondCellsController
        cell!.position?.text = self.results?.races[0].results[indexPath.row-1].position
        cell!.famName?.text = self.results?.races[0].results[indexPath.row-1].driver.familyName
        cell!.team?.text = self.results?.races[0].results[indexPath.row-1].constructor.name
        cell!.points?.text = self.results?.races[0].results[indexPath.row-1].points
        cell!.urlDriver = self.results?.races[0].results[indexPath.row-1].driver.url
        return cell!
    }
}
