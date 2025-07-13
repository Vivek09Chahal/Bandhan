//
//  ProfileCase.swift
//  Bandhan
//
//  Created by Vivek on 7/2/25.
//

import SwiftUI
import Foundation

enum ProfileCaseIters: String, CaseIterable, Hashable {
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

struct AboutSection: View {
    
    @State private var showFullDescription: Bool = false
    let profile: ProfilesData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading){
                Text("We are creating this profile for our daughter, who is a warm-hearted, well-educated, and family-oriented individual. She has been brought up with strong values and a bala")
                    .lineLimit(showFullDescription ? nil : 3)
                    .font(.callout)
                
                Button {
                    withAnimation(.easeInOut) {
                        showFullDescription.toggle()
                    }
                } label: {
                    Text(showFullDescription ? "Less" : "View more...")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.vertical, 4)
                        .foregroundStyle(Color.blue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack { Image(systemName: "ruler"); Text(profile.height) }
            HStack { Image(systemName: "leaf"); Text(profile.caste + " | " + profile.manglik) }
            HStack { Image(systemName: "message"); Text("Mother Tongue is \(profile.motherTongue)") }
            HStack { Image(systemName: "signpost.right.circle"); Text(profile.location) }
            HStack { Image(systemName: "singaporedollarsign.bank.building"); Text(profile.income) }
            
            Text("Career")
                .font(.title2)
            HStack { Image(systemName: "briefcase.fill"); Text(profile.profession) }
            
            Text("Contact")
                .font(.title2)
            VStack(alignment: .leading){
                Text("""
                        Go Premium to contact matches Initiate a voice or a video call with the profiles you like by upgrading to a membership
                    """)
                Button {
                    //
                } label: {
                    Text("Upgrade Now ->")
                        .fontWeight(.bold)
                        .padding(7)
                }
                
            }
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(.red.opacity(0.4))
            }
            
            Text("Education")
                .font(.title2)
            HStack { Image(systemName: "graduationcap.fill"); Text(profile.education) }
        }
        .padding(.bottom, 150)
        .padding(.horizontal)
    }
}

struct FamilySection: View {
    
    let profile: ProfilesData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Family")
                .font(.title2)
            Text("Father: \(profile.family.fatherOccupation)")
            Text("Mother: \(profile.family.motherOccupation)")
            Text("Siblings: \(profile.family.siblings.brothers) Brothers, \(profile.family.siblings.sisters) Sisters")
            Text("Family Type: \(profile.family.familyType)")
        }
        .padding(.bottom, 150)
        .padding(.horizontal)
    }
}

struct PreferenceSection: View {
    
    let profile: ProfilesData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Preferences")
                .font(.title2)
            Text("Age Range: \(profile.partnerPreferences.ageRange)")
            Text("Height: \(profile.partnerPreferences.heightRange)")
            Text("Status: \(profile.partnerPreferences.maritalStatus)")
            Text("Religion: \(profile.partnerPreferences.religion)")
            Text("Caste: \(profile.partnerPreferences.caste)")
        }
        .padding(.bottom, 150)
        .padding(.horizontal)
    }
}
