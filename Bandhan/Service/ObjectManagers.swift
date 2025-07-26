//
//  TabManager.swift
//  Bandhan
//
//  Created by Vivek on 7/12/25.
//

import SwiftUI

class ObjectManagers: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var showUserProfile: Bool = false
    
    @Published var toastManager: Bool = false
}
