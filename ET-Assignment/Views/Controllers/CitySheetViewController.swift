//
//  CitySheetViewController.swift
//  ET-Assignment
//
//  Created by Sree Lakshman on 08/05/25.
//

import Foundation
import UIKit

// MARK: - CitySheetViewController
/// Bottom-sheet controller housing a UIPickerView for city selection.

class CitySheetViewController: UIViewController {
    
    var cities: [String] = []
    var onCitySelected: ((String?) -> Void)?
    
    @IBOutlet weak var cityPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityPicker.dataSource = self
        cityPicker.delegate   = self
    }
}


// MARK: - Picker DataSource & Delegate
extension CitySheetViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count + 1  // "All Cities" option
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return row == 0 ? "All Cities" : cities[row - 1]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCity = row == 0 ? nil : cities[row - 1]
        onCitySelected?(selectedCity)
        dismiss(animated: true, completion: nil)
    }
}
