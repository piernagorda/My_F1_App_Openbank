//
//  SettingsViewController.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 7/8/23.
//

import UIKit

class TimeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var pickerView: UIPickerView?
    @IBOutlet weak var button: UIButton?
    private var yearSelected = "1950"
    private var homeViewController: HomeViewCollectionController?
    
    private var pickerYears: [String] = []
    
    convenience init(homeViewController: HomeViewCollectionController?) {
        self.init(nibName:"TimeView", bundle:nil)
        self.homeViewController = homeViewController
        pickerYears = Array(1950...2023).map { String($0) }
    }
    
    override func viewDidLoad() {
        self.button?.layer.borderColor = UIColor.white.cgColor
        self.button?.layer.borderWidth = 1.5
        self.button?.layer.cornerRadius = 10.0
        self.button?.layer.masksToBounds = true
        super.viewDidLoad()
        self.pickerView!.dataSource = self
        self.pickerView!.delegate = self
    }

    @IBAction func changeTheYear(){
        //CAMBIAR
        print("Changing year to "+self.yearSelected)
        self.homeViewController?.changeYear(year: self.yearSelected)
    }
    
    //-----------------UIPickerView Delegate Methods--------------------------
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        let valueSelected = pickerYears[row] as String
        self.yearSelected = valueSelected
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerYears.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return pickerYears[row]
    }
    
}
