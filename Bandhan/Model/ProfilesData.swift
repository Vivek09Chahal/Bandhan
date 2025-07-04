//
//  ProfileData.swift
//  Bandhan
//
//  Created by Vivek on 7/1/25.
//

import Foundation

struct ProfilesData: Codable, Identifiable {
    var id: String
    var name: String
    var gender: String
    var age: Int
    var height: String
    var maritalStatus: String
    var religion: String
    var caste: String
    var manglik: String
    var motherTongue: String
    var education: String
    var profession: String
    var income: String
    var location: String
    var country: String
    var diet: String
    var smoking: String
    var drinking: String
    var profilePicture: [String]
    var family: Family
    var partnerPreferences: PartnerPreference
}

struct Family: Codable {
    var fatherOccupation: String
    var motherOccupation: String
    var siblings: Sibling
    var familyType: String
    var familyStatus: String
    var familyValues: String
}

struct Sibling: Codable {
    var brothers: Int
    var sisters: Int
}

struct PartnerPreference: Codable {
    var ageRange: String
    var heightRange: String
    var religion: String
    var caste: String
    var education: String
    var location: String
    var maritalStatus: String
}
