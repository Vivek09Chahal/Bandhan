//
//  TabManager.swift
//  Bandhan
//
//  Created by Vivek on 7/12/25.
//

import SwiftUI

class HeaderViewManager: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var showUserProfile: Bool = false
}
