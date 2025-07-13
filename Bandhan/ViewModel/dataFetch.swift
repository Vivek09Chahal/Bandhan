//
//  dataFetch.swift
//  Bandhan
//
//  Created by Vivek on 7/1/25.
//

import Foundation
import SwiftUI

@Observable
class DataFetch {
    
    // profiles data
    var profiles: [ProfilesData] = []
    private var allProfiles: [ProfilesData] = []
    // user data
    var userProfile: ProfilesData? = nil
    
    func userDataLoad(jsonFileName: String){
        self.userProfile = load(jsonFileName)
    }
    
    func profileDataLoad(jsonFileName: String){
        self.allProfiles = load(jsonFileName)
        self.profiles = allProfiles
    }
    
    // loading Data
    func load<T: Decodable>(_ filename: String) -> T {
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
        else {
            fatalError("Couldn't find \(filename) in main bundle")
        }
        
        do {
            let data = try Data(contentsOf: file)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
    }
    
    
    var showHandpickedOnly: Bool = false {
        didSet {
            applyCurrentFilters()
        }
    }
    
    var hasActiveFilters: Bool = false
    private var activeFilterViewModel: FilterViewModel?
    
    func applyFilters(_ viewModel: FilterViewModel) {
        activeFilterViewModel = viewModel
        applyCurrentFilters()
    }
    
    private func applyCurrentFilters() {
        // Start with all profiles
        var filteredProfiles = allProfiles
        
        // Apply handpicked filter if needed
        if showHandpickedOnly {
            // This is a placeholder for actual handpicked logic
            // In a real app, you would have a property in the profile model that indicates if it's handpicked
            filteredProfiles = filteredProfiles.filter { 
                // For demo purpose, let's consider profiles with income containing "LPA" as handpicked
                $0.income.contains("LPA")
            }
        }
        
        // Apply detailed filters if any
        if let viewModel = activeFilterViewModel {
            filteredProfiles = viewModel.filterProfiles(profiles: filteredProfiles)
            hasActiveFilters = !viewModel.appliedFilters.isEmpty
        } else {
            hasActiveFilters = false
        }
        
        // Update the displayed profiles
        self.profiles = filteredProfiles
    }
    
    func resetFilters() {
        activeFilterViewModel = nil
        showHandpickedOnly = false
        hasActiveFilters = false
        self.profiles = allProfiles
    }
}
