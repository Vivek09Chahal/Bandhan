//
//  FilterView.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct FilterView: View {
    enum FilterOption {
        case all, handpicked
    }
    
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedFilter: FilterOption = .all
    @Binding var showFilterSheet: Bool
    @Environment(DataFetch.self) var dataFetch
    
    var body: some View {
        NavigationStack{
            HStack{
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color(UIColor.systemGray6))
                        .frame(height: 50)
                    
                    HStack(spacing: 0) {
                        // All filter option
                        FilterButton(
                            title: "All",
                            isSelected: selectedFilter == .all,
                            action: { 
                                selectedFilter = .all
                                dataFetch.showHandpickedOnly = false
                            }
                        )
                        
                        // Handpicked filter option
                        FilterButton(
                            title: "Handpicked",
                            icon: "diamond.fill",
                            isSelected: selectedFilter == .handpicked,
                            action: { 
                                selectedFilter = .handpicked 
                                dataFetch.showHandpickedOnly = true
                            }
                        )
                    }
                }
                .animation(.linear(duration: 0.2), value: selectedFilter)
                Button {
                    showFilterSheet.toggle()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .resizable()
                            .frame(width: 26, height: 26)
                            .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                        
                        if dataFetch.hasActiveFilters {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 10, height: 10)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

/// A reusable button component for filter options
struct FilterButton: View {
    let title: String
    let icon: String?
    let isSelected: Bool
    let action: () -> Void
    
    init(title: String, icon: String? = nil, isSelected: Bool, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.isSelected = isSelected
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 14))
                }
                Text(title)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(isSelected ? Color(UIColor.systemBackground) : Color.clear)
                    .shadow(color: isSelected ? Color.black.opacity(0.05) : Color.clear, radius: 2, x: 0, y: 1)
            )
            .foregroundColor(isSelected ? .primary : .secondary)
        }
    }
}

#Preview {
    FilterView(showFilterSheet: .constant(true))
        .environment(DataFetch())
}
