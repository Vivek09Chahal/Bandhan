//
//  SearchResult.swift
//  Bandhan
//
//  Created by Vivek on 7/17/25.
//


import SwiftUI

struct SearchResult: View {
    
    @State var searchVM: [ProfilesData] = HomeViewModel().allProfiles
    var searchText: String = ""
    
    var filteredMedicines: [ProfilesData] {
        if searchText.isEmpty {
            return []
        }
        return searchVM.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
            LazyVStack(spacing: 10) {
                ForEach(searchVM) { profile in
                    NavigationLink(destination: Text("Hi")) {
                        HStack {
                            Text(profile.id)
                                .foregroundStyle(.primary)
                                .font(.title2)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(.secondarySystemBackground))
                                        .shadow(color: .black.opacity(0.05), radius: 4)
                                )
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .ignoresSafeArea()
    }
}

#Preview {
    SearchResult()
}
