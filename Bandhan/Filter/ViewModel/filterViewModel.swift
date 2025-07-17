//
//  filterViewModel.swift
//  Bandhan
//
//  Created by Vivek on 7/16/25.
//

import Foundation

enum FilterCategory: String, Identifiable, CaseIterable {
    var id: RawValue { self.rawValue }
    
    case age, height, maritalStatus, religion, motherTongue, caste, subCaste, education, profession, income, location, habits, familyType, siblings
    
    var displayName: String {
        switch self {
        case .age: return "Age"
        case .height: return "Height"
        case .maritalStatus: return "Marital Status"
        case .religion: return "Religion"
        case .caste: return "Caste"
        case .subCaste: return "Subcast"
        case .motherTongue: return "Mother Tongue"
        case .education: return "Education"
        case .profession: return "Profession"
        case .income: return "Income"
        case .location: return "Location"
        case .habits: return "Habits"
        case .familyType: return "Family Type"
        case .siblings: return "Siblings"
        }
    }
}

struct FilterOptionsList {
    let age = ["18-25", "26-35", "36-45", "46-55", "56+"]
    let height = ["4.5-5.0", "5.1-5.5", "5.6-6.0", "6.1-6.5", "6.6+"]
    let maritalStatus = ["Never Married", "Divorced", "Widowed", "Separated", "Annulled"]
    let religion = ["Hindu", "Muslim", "Christian", "Sikh", "Jain", "Buddhist", "Other"]
    let motherTongue = ["Hindi", "English", "Marathi", "Telugu", "Bengali", "Punjabi", "Other"]
    let caste = ["General", "SC", "ST", "OBC", "Brahmin", "Rajput", "Other"]
    let subCaste = ["Brahmin", "Rajput", "Kayastha", "Bania", "Agarwal", "Khatri", "Gond", "Santhal", "Bhils", "Oraon", "Munda", "Bodo", "Yadav", "Kurmi", "Gujjar", "Teli", "Nai", "Kushwaha", "Lodh", "Jat", "Mali", "Nomadic Tribes", "Denotified Tribes", "Unclassified communities"]
    let education = ["B.Tech", "M.Tech", "B.Com", "M.Com", "B.A", "M.A", "B.Sc", "M.Sc", "MBA", "PhD", "Associate's Degree", "High School Diploma", "GED", "Diploma", "Other"]
    let profession = ["Software Developer", "Marketing Manager", "Data Scientist", "Teacher", "Engineer", "Doctor", "Lawyer", "Businessman", "Other"]
    let income = ["₹10-15 LPA", "₹15-20 LPA", "₹20-30 LPA", "₹30-40 LPA", "₹40-50 LPA", "₹50+ LPA"]
    let location = ["Ahmedabad", "Andhra Pradesh", "Assam", "Bangalore", "Bengaluru", "Bhopal", "Bihar", "Chandigarh", "Chennai", "Delhi", "Gujarat", "Haryana", "Hyderabad", "Jaipur", "Karnataka", "Kerala", "Kolkata", "Lucknow", "Madhya Pradesh", "Maharashtra", "Mumbai", "Odisha", "Patna", "Pune", "Punjab", "Rajasthan", "Tamil Nadu", "Telangana", "Uttar Pradesh", "West Bengal"]
    let habits = ["Vegetarian", "Non-Vegetarian", "Vegan", "Drinking", "Non-Drinking", "Smoking", "Non-smoking"]
    let familyType = ["Joint", "Nuclear", "Single-parent", "Blended/Stepfamily", "Extended", "Childless", "Other"]
    let siblings = ["0", "1", "2", "3+"]
}

class FilterViewModel: ObservableObject {
    @Published var selectedCategory: FilterCategory? = .age
    @Published var appliedFilters: [FilterCategory: [String]] = [:]
    
    private let filterOptionsList = FilterOptionsList()
    
    func getOptionsForCategory(_ category: FilterCategory) -> [String] {
        switch category {
        case .age: return filterOptionsList.age
        case .height: return filterOptionsList.height
        case .maritalStatus: return filterOptionsList.maritalStatus
        case .religion: return filterOptionsList.religion
        case .motherTongue: return filterOptionsList.motherTongue
        case .caste: return filterOptionsList.caste
        case .subCaste: return filterOptionsList.subCaste
        case .education: return filterOptionsList.education
        case .profession: return filterOptionsList.profession
        case .income: return filterOptionsList.income
        case .location: return filterOptionsList.location
        case .habits: return filterOptionsList.habits
        case .familyType: return filterOptionsList.familyType
        case .siblings: return filterOptionsList.siblings
        }
    }
    
    func selectCategory(_ category: FilterCategory) {
        selectedCategory = category
    }
    
    func toggleOption(_ option: String) {
        guard let category = selectedCategory else { return }
        
        if appliedFilters[category] == nil {
            appliedFilters[category] = []
        }
        
        if let index = appliedFilters[category]?.firstIndex(of: option) {
            appliedFilters[category]?.remove(at: index)
            if appliedFilters[category]?.isEmpty == true {
                appliedFilters.removeValue(forKey: category)
            }
        } else {
            appliedFilters[category]?.append(option)
        }
    }
    
    func isOptionSelected(_ option: String) -> Bool {
        guard let category = selectedCategory else { return false }
        return appliedFilters[category]?.contains(option) ?? false
    }
    
    func clearAllFilters() {
        appliedFilters.removeAll()
    }
    
    var hasActiveFilters: Bool {
        return !appliedFilters.isEmpty
    }
    
    func filterProfiles(_ profiles: [ProfilesData]) -> [ProfilesData] {
        guard hasActiveFilters else { return profiles }
        
        return profiles.filter { profile in
            for (category, options) in appliedFilters {
                if !matchesFilter(profile: profile, category: category, options: options) {
                    return false
                }
            }
            return true
        }
    }
    
    private func matchesFilter(profile: ProfilesData, category: FilterCategory, options: [String]) -> Bool {
        switch category {
        case .age:
            return matchesAgeRange(profile.age, options: options)
        case .height:
            return options.contains(profile.height)
        case .maritalStatus:
            return options.contains(profile.maritalStatus)
        case .religion:
            return options.contains(profile.religion)
        case .motherTongue:
            return options.contains(profile.motherTongue)
        case .caste:
            return options.contains(profile.caste)
        case .subCaste:
            return options.contains(profile.caste) // Using caste as subcaste for now
        case .education:
            return options.contains(profile.education)
        case .profession:
            return options.contains(profile.profession)
        case .income:
            return options.contains(profile.income)
        case .location:
            return options.contains(profile.location)
        case .habits:
            return matchesHabits(profile: profile, options: options)
        case .familyType:
            return options.contains(profile.family.familyType)
        case .siblings:
            return matchesSiblings(profile: profile, options: options)
        }
    }
    
    private func matchesAgeRange(_ age: Int, options: [String]) -> Bool {
        for option in options {
            switch option {
            case "18-25": if age >= 18 && age <= 25 { return true }
            case "26-35": if age >= 26 && age <= 35 { return true }
            case "36-45": if age >= 36 && age <= 45 { return true }
            case "46-55": if age >= 46 && age <= 55 { return true }
            case "56+": if age >= 56 { return true }
            default: break
            }
        }
        return false
    }
    
    private func matchesHabits(profile: ProfilesData, options: [String]) -> Bool {
        for option in options {
            switch option {
            case "Vegetarian", "Non-Vegetarian", "Vegan":
                if options.contains(profile.diet) { return true }
            case "Drinking", "Non-Drinking":
                if options.contains(profile.drinking) { return true }
            case "Smoking", "Non-smoking":
                if options.contains(profile.smoking) { return true }
            default: break
            }
        }
        return false
    }
    
    private func matchesSiblings(profile: ProfilesData, options: [String]) -> Bool {
        let totalSiblings = profile.family.siblings.brothers + profile.family.siblings.sisters
        for option in options {
            switch option {
            case "0": if totalSiblings == 0 { return true }
            case "1": if totalSiblings == 1 { return true }
            case "2": if totalSiblings == 2 { return true }
            case "3+": if totalSiblings >= 3 { return true }
            default: break
            }
        }
        return false
    }
}
