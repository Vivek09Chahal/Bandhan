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
    
    private var allProfiles: [ProfilesData] = []
    var profiles: [ProfilesData] = []
    var showHandpickedOnly: Bool = false {
        didSet {
            applyCurrentFilters()
        }
    }
    var hasActiveFilters: Bool = false
    private var activeFilterViewModel: FilterViewModel?
    
    init(){
        self.allProfiles = load("ProfilesData")
        self.profiles = allProfiles
    }
    
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
            filteredProfiles = viewModel.filterProfiles(filteredProfiles)
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
        profiles = allProfiles
    }
}
