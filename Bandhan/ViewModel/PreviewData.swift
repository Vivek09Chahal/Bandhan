//
//  PreviewData.swift
//  Bandhan
//
//  Created by Vivek on 7/2/25.
//

import Foundation

extension ProfilesData {
    static let sampleProfile = ProfilesData(
        id: "U1001",
        name: "Ananya Sharma",
        gender: "Female",
        age: 28,
        height: "5'5\"",
        maritalStatus: "Never Married",
        religion: "Hindu",
        caste: "Brahmin",
        manglik: "No",
        motherTongue: "Hindi",
        education: "MBA, IIM Bangalore",
        profession: "Marketing Manager",
        income: "₹15 LPA",
        location: "Bangalore, India",
        country: "India",
        diet: "Vegetarian",
        smoking: "No",
        drinking: "No",
        profilePicture: "https://i.pinimg.com/736x/3d/fc/51/3dfc51dbcb22d4d274b4f5498a7c6c85.jpg",
        family: Family(
            fatherOccupation: "Retired Banker",
            motherOccupation: "Homemaker",
            siblings: Sibling(
                brothers: 1,
                sisters: 0
            ),
            familyType: "Nuclear",
            familyStatus: "Upper Middle Class",
            familyValues: "Traditional"
        ),
        partnerPreferences: PartnerPreference(
            ageRange: "28-32",
            heightRange: "5'7\" - 6'1\"",
            religion: "Hindu",
            caste: "Brahmin",
            education: "MBA or higher",
            location: "India",
            maritalStatus: "Never Married"
        )
    )
    
    static let sampleProfiles: [ProfilesData] = [sampleProfile]
}

extension DataFetch {
    static let preview = DataFetch()
}

