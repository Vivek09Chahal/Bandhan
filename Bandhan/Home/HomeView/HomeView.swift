//
//  HomeView.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct HomeView: View {
    enum FilterOption {
        case all, handpicked
    }
    
    @State private var selectedFilter: FilterOption = .all
    
    var body: some View {
        NavigationStack{
            // MARK: - Top Section
            HeaderView()
                .padding(.horizontal)
            
            // MARK: - Filter View
            FilterView()
                .padding(.horizontal)
            
            // MARK: - Profile Scroll Section
            VStack{
                ScrollView {
                    LazyVStack {
                        ForEach(0..<10) { index in
                            ProfileCard()
                                .containerRelativeFrame(.vertical)
                                .id(index)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                .padding()
            }
        }
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}
