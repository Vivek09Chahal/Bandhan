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
    
    private var profileDataService = profileDataServices()
    private var cancellable = Set<AnyCancellable>()
    
    init(){
        addSubscriber()
        setupFilterSubscriber()
    }
    
    func addSubscriber(){
        profileDataService.$allProfiles
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] returnedProfiles in
                self?.allProfiles = returnedProfiles
                self?.applyFilters()
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
