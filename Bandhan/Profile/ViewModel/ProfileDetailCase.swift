//
//  ProfileCase.swift
//  Bandhan
//
//  Created by Vivek on 7/2/25.
//

import SwiftUI
import Foundation

enum ProfileDetailCase: String, CaseIterable, Hashable {
    case about, family, partnerPreference
    
    var profileTabTitle: String {
        switch self {
        case .about: return "About"
        case .family: return "Family" 
        case .partnerPreference: return "Preferences"
        }
    }
    
    var scrollID: String {
        return self.rawValue // used in .scrollTo()
    }
    
    @ViewBuilder func tabContentView(profile: ProfilesData) -> some View {
        switch self {
        case .about:
            AboutSection(profile: profile)
        case .family:
            FamilySection(profile: profile)
        case .partnerPreference:
            PreferenceSection(profile: profile)
        }
    }
}
