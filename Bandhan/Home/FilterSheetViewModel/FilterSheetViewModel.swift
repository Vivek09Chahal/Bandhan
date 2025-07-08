//
//  FilterSheetViewModel.swift
//  Bandhan
//
//  Created by Vivek on 7/3/25.
//

import Foundation
import SwiftUI

/// Enum representing different filter categories available in the app
/// Each case corresponds to a specific filter criterion that can be applied
enum FilterSheetViewModel: String, CaseIterable, Identifiable {
    case age, height, maritalStatus, religion, caste, motherTongue, education, profession, income, location, habits, brothers, sisters, familyType
    
    /// Unique identifier for each filter type, using the raw value
    var id: String { self.rawValue }
    
    /// User-friendly display name for each filter category
    var displayName: String {
        switch self {
        case .age: return "Age"
        case .height: return "Height"
        case .maritalStatus: return "Marital Status"
        case .religion: return "Religion"
        case .caste: return "Caste"
        case .motherTongue: return "Mother Tongue"
        case .education: return "Education"
        case .profession: return "Profession"
        case .income: return "Income"
        case .location: return "Location"
        case .habits: return "Habits"
        case .brothers: return "Brothers"
        case .sisters: return "Sisters"
        case .familyType: return "Family Type"
        }
    }
}

/// Structure containing all available filter options for each filter category
struct FilterOptions {
    /// Age ranges available for filtering
    let age = ["18-25", "26-35", "36-45", "46-55", "56+"]
    
    /// Height ranges available for filtering (in feet)
    let height = ["4.5-5.0", "5.1-5.5", "5.6-6.0", "6.1-6.5", "6.6+"]
    
    /// Marital status options
    let maritalStatus = ["Never Married", "Divorced", "Widowed", "Separated", "Annulled"]
    
    /// Religious affiliations
    let religion = ["Hindu", "Muslim", "Christian", "Sikh", "Jain", "Buddhist", "Other"]
    
    /// Mother tongue language options
    let motherTongue = ["Hindi", "English", "Marathi", "Telugu", "Bengali", "Punjabi", "Other"]
    
    /// Caste categories
    let caste = ["General", "SC", "ST", "OBC", "Brahmin", "Rajput", "Other"]
    
    /// Sub-caste categories (Note: Currently not used in filtering logic)
    let subCaste = ["Brahmin", "Rajput", "Kayastha", "Bania", "Agarwal", "Khatri", "Gond", "Santhal", "Bhils", "Oraon", "Munda", "Bodo", "Yadav", "Kurmi", "Gujjar", "Teli", "Nai", "Kushwaha", "Lodh", "Jat", "Mali", "Nomadic Tribes", "Denotified Tribes", "Unclassified communities"]
    
    /// Educational qualifications
    let education = ["B.Tech", "M.Tech", "B.Com", "M.Com", "B.A", "M.A", "B.Sc", "M.Sc", "MBA", "PhD", "Associate's Degree", "High School Diploma", "GED", "Diploma", "Other"]
    
    /// Professional occupations
    let profession = ["Software Developer", "Marketing Manager", "Data Scientist", "Teacher", "Engineer", "Doctor", "Lawyer", "Businessman", "Other"]
    
    /// Income brackets (Lakh Per Annum)
    let income = ["₹10-15 LPA", "₹15-20 LPA", "₹20-30 LPA", "₹30-40 LPA", "₹40-50 LPA", "₹50+ LPA"]
    
    /// Location options across India
    let location = ["Ahmedabad", "Andhra Pradesh", "Assam", "Bangalore", "Bengaluru", "Bhopal", "Bihar", "Chandigarh", "Chennai", "Delhi", "Gujarat", "Haryana", "Hyderabad", "Jaipur", "Karnataka", "Kerala", "Kolkata", "Lucknow", "Madhya Pradesh", "Maharashtra", "Mumbai", "Odisha", "Patna", "Pune", "Punjab", "Rajasthan", "Tamil Nadu", "Telangana", "Uttar Pradesh", "West Bengal"]
    
    /// Personal habits and lifestyle preferences
    let habits = ["Vegetarian", "Non-Vegetarian", "Vegan", "Drinking", "Non-Drinking", "Smoking", "Non-smoking"]
    
    /// Family structure types
    let familyType = ["Joint", "Nuclear", "Single-parent", "Blended/Stepfamily", "Extended", "Childless", "Other"]
    
    /// Number of brothers options
    let brothers = ["0", "1", "2", "3+"]
    
    /// Number of sisters options
    let sisters = ["0", "1", "2", "3+"]
}

/// Observable class that manages the filter state and filtering logic
@Observable
class FilterViewModel {
    /// Currently selected filters that haven't been applied yet
    var selectedFilters: [FilterSheetViewModel: [String]] = [:]
    
    /// Filters that have been applied to the profile list
    var appliedFilters: [FilterSheetViewModel: [String]] = [:]
    
    /// All available filter options
    let filterOptions = FilterOptions()
    
    /// Returns the appropriate options array for a given filter type
    /// - Parameter filter: The filter category to get options for
    /// - Returns: Array of string options for the specified filter
    func getOptionsForFilter(_ filter: FilterSheetViewModel) -> [String] {
        switch filter {
        case .age: return filterOptions.age
        case .height: return filterOptions.height
        case .maritalStatus: return filterOptions.maritalStatus
        case .religion: return filterOptions.religion
        case .caste: return filterOptions.caste
        case .motherTongue: return filterOptions.motherTongue
        case .education: return filterOptions.education
        case .profession: return filterOptions.profession
        case .income: return filterOptions.income
        case .location: return filterOptions.location
        case .habits: return filterOptions.habits
        case .brothers: return filterOptions.brothers
        case .sisters: return filterOptions.sisters
        case .familyType: return filterOptions.familyType
        }
    }
    
    /// Checks if a specific option is currently selected for a given filter
    /// - Parameters:
    ///   - option: The option string to check
    ///   - filter: The filter category to check in
    /// - Returns: Boolean indicating whether the option is selected
    func isOptionSelected(_ option: String, for filter: FilterSheetViewModel) -> Bool {
        return selectedFilters[filter]?.contains(option) ?? false
    }
    
    /// Toggles the selection state of an option for a specific filter
    /// - Parameters:
    ///   - option: The option string to toggle
    ///   - filter: The filter category the option belongs to
    func toggleOption(option: String, for filter: FilterSheetViewModel) {
        // Initialize empty array for filter if it doesn't exist
        if selectedFilters[filter] == nil {
            selectedFilters[filter] = []
        }
        
        // Remove option if already selected, otherwise add it
        if let index = selectedFilters[filter]?.firstIndex(of: option) {
            selectedFilters[filter]?.remove(at: index)
            // Remove the filter key if no options remain
            if selectedFilters[filter]?.isEmpty ?? true {
                selectedFilters.removeValue(forKey: filter)
            }
        } else {
            selectedFilters[filter]?.append(option)
        }
    }
     
    /// Applies the currently selected filters
    func applyFilters() {
        appliedFilters = selectedFilters
    }
    
    /// Resets all selected filters
    func resetFilters() {
        selectedFilters = [:]
    }
    
    /// Filters profiles based on currently applied filters
    /// - Parameter profiles: Array of profiles to filter
    /// - Returns: Filtered array of profiles that match all applied filters
    func filterProfiles(profiles: [ProfilesData]) -> [ProfilesData] {
        // Return all profiles if no filters are applied
        guard !appliedFilters.isEmpty else { return profiles }
        
        return profiles.filter { profile in
            for (filter, options) in appliedFilters {
                switch filter {
                case .age:
                    if !options.isEmpty {
                        // Check if profile age falls within any of the selected age ranges
                        let ageMatched = options.contains { range in
                            let parts = range.split(separator: "-")
                            if parts.count == 2, 
                               let lower = Int(parts[0]), 
                               let upper = Int(parts[1].hasSuffix("+") ? String(parts[1].dropLast()) : String(parts[1])) {
                                // Handle ranges with "+" suffix (e.g., "56+")
                                return profile.age >= lower && (parts[1].hasSuffix("+") ? profile.age >= upper : profile.age <= upper)
                            }
                            return false
                        }
                        if !ageMatched { return false }
                    }
                case .height:
                    if !options.isEmpty {
                        // TODO: Implement actual height comparison logic
                        // Current implementation is a placeholder
                        let heightMatched = options.contains { _ in true } 
                        if !heightMatched { return false }
                    }
                case .maritalStatus:
                    // Simple equality check for marital status
                    if !options.isEmpty && !options.contains(profile.maritalStatus) {
                        return false
                    }
                case .religion:
                    // Simple equality check for religion
                    if !options.isEmpty && !options.contains(profile.religion) {
                        return false
                    }
                case .caste:
                    // Simple equality check for caste
                    if !options.isEmpty && !options.contains(profile.caste) {
                        return false
                    }
                case .motherTongue:
                    // Simple equality check for mother tongue
                    if !options.isEmpty && !options.contains(profile.motherTongue) {
                        return false
                    }
                case .education:
                    if !options.isEmpty {
                        // Check if profile's education contains any of the selected options
                        let educationMatched = options.contains { option in
                            profile.education.contains(option)
                        }
                        if !educationMatched { return false }
                    }
                case .profession:
                    if !options.isEmpty {
                        // Check if profile's profession contains any of the selected options
                        let professionMatched = options.contains { option in
                            profile.profession.contains(option)
                        }
                        if !professionMatched { return false }
                    }
                case .income:
                    if !options.isEmpty {
                        // TODO: Implement actual income comparison logic
                        // Current implementation is a placeholder
                        let incomeMatched = options.contains { _ in true }
                        if !incomeMatched { return false }
                    }
                case .location:
                    if !options.isEmpty {
                        // Check if profile's location contains any of the selected options
                        let locationMatched = options.contains { option in
                            profile.location.contains(option)
                        }
                        if !locationMatched { return false }
                    }
                case .habits:
                    if !options.isEmpty {
                        // Check diet preferences (Vegetarian, Non-Vegetarian, Vegan)
                        let dietMatched = options.contains { option in
                            if option == "Vegetarian" || option == "Non-Vegetarian" || option == "Vegan" {
                                return profile.diet == option
                            }
                            return true
                        }
                        
                        // Check smoking preferences
                        let smokingMatched = options.contains { option in
                            if option == "Smoking" {
                                return profile.smoking == "Yes"
                            } else if option == "Non-smoking" {
                                return profile.smoking == "No"
                            }
                            return true
                        }
                        
                        // Check drinking preferences
                        let drinkingMatched = options.contains { option in
                            if option == "Drinking" {
                                return profile.drinking == "Yes"
                            } else if option == "Non-Drinking" {
                                return profile.drinking == "No"
                            }
                            return true
                        }
                        
                        // Profile must match all selected habit filters
                        if (!dietMatched || !smokingMatched || !drinkingMatched) { return false }
                    }
                case .brothers:
                    if !options.isEmpty {
                        // Check number of brothers
                        let brothersMatched = options.contains { option in
                            if option == "0" {
                                return profile.family.siblings.brothers == 0
                            } else if option == "1" {
                                return profile.family.siblings.brothers == 1
                            } else if option == "2" {
                                return profile.family.siblings.brothers == 2
                            } else if option == "3+" {
                                return profile.family.siblings.brothers >= 3
                            }
                            return false
                        }
                        if !brothersMatched { return false }
                    }
                case .sisters:
                    if !options.isEmpty {
                        // Check number of sisters
                        let sistersMatched = options.contains { option in
                            if option == "0" {
                                return profile.family.siblings.sisters == 0
                            } else if option == "1" {
                                return profile.family.siblings.sisters == 1
                            } else if option == "2" {
                                return profile.family.siblings.sisters == 2
                            } else if option == "3+" {
                                return profile.family.siblings.sisters >= 3
                            }
                            return false
                        }
                        if !sistersMatched { return false }
                    }
                case .familyType:
                    // Simple equality check for family type
                    if !options.isEmpty && !options.contains(profile.family.familyType) {
                        return false
                    }
                }
            }
            // Profile matches all applied filters
            return true
        }
    }
}
