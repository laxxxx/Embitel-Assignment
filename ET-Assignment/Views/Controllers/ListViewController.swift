//
//  ViewController.swift
//  ET-Assignment
//
//  Created by Sree Lakshman on 08/05/25.
//

import UIKit

// MARK: - ListViewController
/// Displays a list of users and allows filtering via a bottom-sheet city picker.

class ListViewController: UIViewController {
    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchUsers()
    }
    
    // MARK: UI Setup
    func setupUI() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "UserTableViewCell")
        self.filterButton.configuration?.baseBackgroundColor = .label
    }
    
    // MARK: Bindings
    func bindViewModel() {
        viewModel.onDataUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    @IBAction func didTapFilter(_ sender: UIButton) {
        showBottomSheet()
    }
    
    private func showBottomSheet() {
        /// Instantiates and presents CitySheetViewController as a bottom sheet
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let bottomSheetVC = storyboard
            .instantiateViewController(identifier: "CitySheetViewController")
                as? CitySheetViewController
        else { return }
        
        // Pass data and callback
        bottomSheetVC.cities = viewModel.cities
        bottomSheetVC.onCitySelected = { [weak self] selectedCity in
            self?.viewModel.filterUsers(by: selectedCity)
            self?.filterButton.setTitle(selectedCity ?? "All Cities", for: .normal)
        }
        
        // Configure bottom sheet appearance and behavior
        if let sheet = bottomSheetVC.sheetPresentationController {
            sheet.detents = [.medium(), .medium()]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        
        // Present the sheet
        present(bottomSheetVC, animated: true)
    }
}

// MARK: - TableView DataSource & Delegate
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
