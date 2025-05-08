//
//  ViewController.swift
//  ET-Assignment
//
//  Created by Sree Lakshman on 08/05/25.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchUsers()
    }
    
    func setupUI() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.cityPicker.delegate = self
        self.cityPicker.dataSource = self
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "UserTableViewCell")
    }
    
    func bindViewModel() {
        viewModel.onDataUpdate = { [weak self] in
            self?.tableView.reloadData()
            self?.cityPicker.reloadAllComponents()
        }
    }
}

    extension ListViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.filteredUsers.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell
            
            let user = viewModel.filteredUsers[indexPath.row]
            cell?.configure(with: user)
            return cell!
        }
    }

    extension ListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
        func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return viewModel.cities.count + 1  // +1 for "All Cities"
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return row == 0 ? "All Cities" : viewModel.cities[row - 1]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let selectedCity = row == 0 ? nil : viewModel.cities[row - 1]
            viewModel.filterUsers(by: selectedCity)
        }
    }

