//
//  homeViewModel.swift
//  Bandhan
//
//  Created by Vivek on 7/14/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allProfiles: [ProfilesData] = []
    @Published var filteredProfiles: [ProfilesData] = []
    @Published var filterViewModel = FilterViewModel()
    @Published var isLoading: Bool = false
    
    private var profileDataService = profileDataServices()
    private var cancellable = Set<AnyCancellable>()
    
    init(){
        isLoading = true
        addSubscriber()
        setupFilterSubscriber()
    }
    
    func addSubscriber(){
        profileDataService.$allProfiles
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] returnedProfiles in
                self?.allProfiles = returnedProfiles
                self?.applyFilters()
                // Only set isLoading to false when data is actually loaded
                if !returnedProfiles.isEmpty {
                    self?.isLoading = false
                }
            }
            .store(in: &cancellable)
    }
    
    private func setupFilterSubscriber() {
        filterViewModel.$appliedFilters
            .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applyFilters()
            }
            .store(in: &cancellable)
    }
    
    private func applyFilters() {
        filteredProfiles = filterViewModel.filterProfiles(allProfiles)
    }
    
    var displayProfiles: [ProfilesData] {
        return filterViewModel.hasActiveFilters ? filteredProfiles : allProfiles
    }
}
