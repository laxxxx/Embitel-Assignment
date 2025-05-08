//
//  ListViewModel.swift
//  ET-Assignment
//
//  Created by Sree Lakshman on 08/05/25.
//

import Foundation

class ListViewModel {
    private var allUsers: [User] = []
    var filteredUsers: [User] = []
    var cities: [String] = []
    var onDataUpdate: (() -> Void)?
    
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
    
    func filterUsers(by city: String?) {
        if let city = city, !city.isEmpty {
            filteredUsers = allUsers.filter { $0.address.city == city }
        } else {
            filteredUsers = allUsers
        }
        onDataUpdate?()
    }
}
