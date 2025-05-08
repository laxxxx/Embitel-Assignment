//
//  ListViewModel.swift
//  ET-Assignment
//
//  Created by Sree Lakshman on 08/05/25.
//

import Foundation

// MARK: - ListViewModel
/// Responsible for fetching and filtering user data for the ListViewController.

class ListViewModel {
    private var allUsers: [User] = []
    var filteredUsers: [User] = []
    var cities: [String] = []
    var onDataUpdate: (() -> Void)?
    
    /// Fetches users from the network and prepares data for display
    func fetchUsers() {
        NetworkManager.shared.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.allUsers = users
                self?.filteredUsers = users
                self?.cities = Array(Set(users.map { $0.address.city })).sorted()
                DispatchQueue.main.async { self?.onDataUpdate?() }
            case .failure(let error):
                print("Failed to fetch users: \(error)")
            }
        }
    }
    
    /// Filters users by the selected city. If city is nil, all users are shown.
    /// - Parameter city: Optional city name to filter by
    func filterUsers(by city: String?) {
        if let city = city, !city.isEmpty {
            filteredUsers = allUsers.filter { $0.address.city == city }
        } else {
            filteredUsers = allUsers
        }
        onDataUpdate?()
    }
}
